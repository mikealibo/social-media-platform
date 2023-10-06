# frozen_string_literal: true

class User::PostsController < User::BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def show; end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@post,
          partial: 'user/posts/form',
          locals: {
            post: @post
          }
        )
      end
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('posts', 
              partial: 'user/posts/styled/post', 
              locals: { 
                post: @post
              }
            ),
            turbo_stream.update('posts-form', 
              partial: 'user/posts/form',
              locals: { 
                post: current_user.posts.build
              }
            )
          ]
        end
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('posts-form', 
              partial: 'user/posts/form',
              locals: { 
                post: @post
              }
            )
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@post, 
              partial: 'user/posts/post', 
              locals: { 
                post: @post
              }
            )
          ]
        end
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('post-form', 
              partial: 'user/posts/form',
              locals: { 
                post: @post
              }
            )
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@post)
        ]
      end
      format.html { redirect_back fallback_location: root_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end