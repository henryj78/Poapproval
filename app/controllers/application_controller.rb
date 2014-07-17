class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'csv'
  
  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user
  
  def protect
    logged_in? ? true : access_denied
  end#end protect
 
  # Returns the currently logged in user or nil if there isn't one
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by_id(session[:user_id]) 
  end#current_user
   
  # Filter method to enforce a login requirement
  # Apply as a before_filter on any controller you want to protect
  def authenticate
    logged_in? ? true : access_denied
  end
   
  # Predicate method to test for a logged in user    
  def logged_in?
    current_user.is_a? User
  end#logged_in
  
  def access_denied
    redirect_to log_in_path
    flash[:notice] = "Your Access was denied"
    return false      
  end#access denied  
end
