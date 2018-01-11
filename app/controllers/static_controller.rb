class StaticController < ApplicationController
  before_action :require_token, only: [:feed]
  swagger_controller :static, 'Static'
  def index
    @users = User.all
    @groups = Group.all
  end
  swagger_api :feed do
      summary "Shows a feed for authenticated used"
      param :header, "Authorization", :string, :required, "Authentication token"
  end
  def feed

  end
end
