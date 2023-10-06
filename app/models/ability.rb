# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [:edit, :update, :destroy], Post, user_id: user.id
    can [:read, :create,], Post


    can [:read, :create], Comment
  end
end
