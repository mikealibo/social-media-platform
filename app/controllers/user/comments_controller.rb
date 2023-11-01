# frozen_string_literal: true

class User::CommentsController < User::BaseController
  load_and_authorize_resource

  before_action :set_post, only: [:edit, :create, :update, :see_all, :see_less]
  before_action :set_comment, only: [:edit, :update]

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@comment,
          partial: 'user/comments/form',
          locals: {
            model: [@comment.post, @comment],
            resource: @comment
          }
        )
      end
    end
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("comments_post_#{@post.id}",
              partial: 'user/comments/comment', 
              locals: {
                comment: @comment
              }
            ),
            turbo_stream.replace("post_#{@post.id}_new_comment",
              partial: 'user/comments/form',
              locals: {
                model: [@post, @post.comments.build],
                resource: @post
              }
            )
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("post_#{@post.id}_new_comment",
              partial: 'user/comments/form',
              locals: {
                model: [@post, @post.comments.build],
                resource: @comment
              }
            )
          ]
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@comment, 
              partial: 'user/comments/comment', 
              locals: { 
                comment: @comment
              }
            )
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@comment, 
              partial: 'user/comments/form',
              locals: { 
                model: [@comment.post, @comment],
                resource: @comment
              }
            )
          ]
        end
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@comment)
        ]
      end
    end
  end

  def see_all
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("comments_post_#{@post.id}",
            partial: 'user/comments/comments',
            locals: {
              record: @post,
              comments: @post.comments.order(id: :desc)
            }
          )
        ]
      end
    end
  end

  def see_less
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("comments_post_#{@post.id}",
            partial: 'user/comments/comments',
            locals: {
              record: @post,
              comments: limit_comments
            }
          )
        ]
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def limit_comments
    @post.total_comments_to_display.order(id: :desc)
  end
end