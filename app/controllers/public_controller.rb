class PublicController < ApplicationController
  def index
    current_user.present? ? user_logged_in : user_not_logged_in
  end

  private

  def user_logged_in
    @posts = Post.all.order(id: :desc)
    @post = current_user.posts.build
  end

  def user_not_logged_in
  end
end
