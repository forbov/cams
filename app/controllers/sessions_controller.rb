class SessionsController < ApplicationController
   def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      
      sign_in user
      case user.user_role_code
      when "COUNCIL"
        redirect_to assets_path
      when "ADMIN"
        redirect_to users_path
      else
        redirect_to council_reports_path
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
