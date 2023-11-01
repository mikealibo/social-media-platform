class PublicController < ApplicationController
  def index
    @posts = Post.all.order(id: :desc)
    @post = current_user.posts.build
  end
end
