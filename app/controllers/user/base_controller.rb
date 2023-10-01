# frozen_string_literal: true

class User::BaseController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource
end