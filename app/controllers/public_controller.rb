class PublicController < ApplicationController
  def index
    current_user.present? ? user_logged_in : user_not_logged_in
  end

  private

  def user_logged_in
    @post = current_user.posts.build

    @posts = Post.all.order(id: :desc)
  end

  def user_not_logged_in
  end
end
