class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  
  def app_name
    render "pages/main"
  end

end
