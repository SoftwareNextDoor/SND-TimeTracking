class ApplicationController < ActionController::Base
  protect_from_forgery #:secret => "waaaaa"
  include SessionsHelper
end
