class SessionsController < ApplicationController
    def new  # for login request the login form
        @user = User.new 
        render :new
    end

    def create # for login  submit the login form
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user 
            login!(@user)
        else 
            flash[:errors] = ['Invalid credentials']
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url 
    end
end
