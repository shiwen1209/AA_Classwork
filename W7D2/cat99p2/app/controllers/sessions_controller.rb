class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    def new 
        @user = User.new 
        render :new
    end 

    def create 
        @user = User.find_by_cendentials(params[:user][:user_name], params[:user][:password])
        if @user
            session[:session_token] = @user.reset_session_token!
            redirect_to cats_url
        else 
            render :new 
        end 
    end 

    def destroy 
        logout!
        redirect_to new_session_url 
    end 
end
