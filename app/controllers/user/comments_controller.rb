# frozen_string_literal: true

class User::CommentsController < User::BaseController
  before_action :set_post

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
            turbo_stream.update("comments_form_post_#{@post.id}", 
              partial: 'user/comments/form',
              locals: { 
                record: @post
              }
            )
          ]
        end
        format.html { redirect_back fallback_location: root_path, notice: 'Comment was successfully created.' }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("comments_form_post_#{@post.id}", 
              partial: 'user/comments/form',
              locals: { 
                record: @post
              }
            )
          ]
        end
        format.html { redirect_back fallback_location: root_path, notice: 'Comment was not successfully created.' }
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end