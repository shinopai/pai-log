class UsersController < ApplicationController
  before_action :authenticate_user!

  def show_profile
    @user = User.find(params[:id])

    render :profile
  end
end
