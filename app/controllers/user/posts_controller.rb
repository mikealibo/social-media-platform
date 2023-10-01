# frozen_string_literal: true

class User::PostsController < User::BaseController
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_back fallback_location: root_path, notice: 'Post was successfully created.' }
      else
        format.html { redirect_back fallback_location: root_path, notice: 'Post was not successfully created.' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end