class ApplicationController < ActionController::Base
  protect_from_forgery

  def app_name
    render "pages/main"
  end

end
