module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end
  
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
    
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token) 
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def init_globals
    if signed_in? and @current_user.council_id?
      @current_council ||= Council.find(@current_user.council_id)
    else
      @current_council = nil
    end
  end
end
