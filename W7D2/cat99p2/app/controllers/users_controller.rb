class UsersController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    
    def new 
        @user = User.new 
        render :new
    end 

    def index
        @users = User.all
        render :index
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show 
    end

    def create 
        @user = User.new(user_params)
        if @user.save
            self.login!(@user)
            # redirect_to cats_url
        else 
            render :new 
        end 
    end 


    private
    def user_params
        params.require(:user).permit(:user_name, :password)
    end


end
