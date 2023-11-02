# frozen_string_literal: true

class User::ProfilesController < User::BaseController
  before_action :set_user, only: [:password, :update_password, :edit, :update]  

  def password
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("profile", 
            partial: 'devise/registrations/edit',
            locals: {
              resource: current_user,
              resource_name: :user
            }
          )
        ]
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update(user_params.except(:profile_picture, :bio_information, :email, :username, :first_name, :middle_name, :last_name))
        # # Sign in the user by passing validation in case their password changed
        bypass_sign_in(@user)
        redirect_to root_path

      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("profile", 
              partial: 'devise/registrations/edit',
              locals: {
                resource: @user,
                resource_name: :user
              }
            )
          ]
        end
      end
    end
  end

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
      if @user.update(user_params.except(:password, :password_confirmation))
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
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:profile_picture, :bio_information, :email, :username, :first_name, :middle_name, :last_name, :password, :password_confirmation)
  end
end
