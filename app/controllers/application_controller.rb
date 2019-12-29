class ApplicationController < ActionController::Base
  include UsersHelper
  protect_from_forgery with: :exception
end
