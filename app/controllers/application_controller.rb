class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def authenticate_admin_user!
        authenticate_or_request_with_http_basic("Admin Login") do |name, password| 
        name == "admin" && password == "password"
        end
    end

    def current_admin_user
        session[:admin_user]
    end

end
