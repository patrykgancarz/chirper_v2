class SessionsController < ApplicationController
  def create
      user = User.find_by(index: params[:session][:index])
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to user
      else
            render 'new'
      end
  end
  def destroy
  log_out
  redirect_to root_url
end
end
