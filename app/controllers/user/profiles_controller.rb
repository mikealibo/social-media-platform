# frozen_string_literal: true

class User::ProfilesController < User::BaseController
  before_action :set_user, only: [:edit, :update]  

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("profile", 
            partial: 'user/profiles/form',
            locals: {
              user: @user
            }
          )
        ]
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("profile", 
              partial: 'user/profiles/details',
              locals: {
                user: @user
              }
            )
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("edit_user_#{@user.id}",
              partial: 'user/profiles/form',
              locals: {
                user: @user
              }
            )
          ]
        end
      end
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:bio_information, :email, :username, :first_name, :middle_name, :last_name)
  end
end
