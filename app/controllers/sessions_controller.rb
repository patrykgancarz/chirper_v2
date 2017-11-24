class SessionsController < ApplicationController
  swagger_controller	:session,	"Authentication"
  swagger_api	:create	do
    summary	"Gather	a	token"
    param	:form,	"session[index]",	:string,	:required,	"Users	index"
    param	:form,	"session[password]",	:string,	:required,	"Users	password"
  end
  def create
      user = User.find_by(index: params[:session][:index])
      if user && user.authenticate(params[:session][:password])
        log_in user
        redirect_to user
      else
            render 'new'
      end
  end
  swagger_api	:destroy	do
    summary	"Invalidate	a	token"
    param	:header,	"Authorization",	:string,	:required,	"Authentication	token"
  end
  def destroy
  log_out
  redirect_to root_url
end
end
