class StaticController < ApplicationController
  def index
    @users = User.all
    @groups = Group.all
  end
  before_action :require_token, only: [:feed]
  def feed

  end
end
