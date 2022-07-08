class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      render json: @user
    else
      render json: @user.errors.full_messages, status: 404
    end
  end

  def destroy
    # logged_in? ? (flash[:errors] = 404) : ( logout, render {} )
    logout

    # cannot be redirecting after
  end
end
