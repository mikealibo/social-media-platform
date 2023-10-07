# frozen_string_literal: true

class User::ProfilesController < User::BaseController
  def edit; end

  def show; end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to profile_path, notice: "Profile has been updated." }
        # format.turbo_stream do
        #   render turbo_stream: [
        #     turbo_stream.replace(@post, 
        #       partial: 'user/posts/post', 
        #       locals: { 
        #         post: @post
        #       }
        #     )
        #   ]
        # end
      else
        # format.turbo_stream do
        #   render turbo_stream: [
        #     turbo_stream.update('post-form', 
        #       partial: 'user/posts/form',
        #       locals: { 
        #         post: @post
        #       }
        #     )
        #   ]
        # end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:bio_information, :email, :username, :first_name, :middle_name, :last_name)
  end
end