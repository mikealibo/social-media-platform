# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [:edit, :update, :destroy], Post, user_id: user.id
    can [:read, :create], Post

    can [:edit, :update, :destroy], Comment, user_id: user.id
    can [:read, :create, :see_all, :see_less], Comment
  end
end
