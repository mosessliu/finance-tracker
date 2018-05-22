class UsersController < ApplicationController 
  before_action :set_user, only: [:show]
  
  def my_portfolio
    params[:display_style] = "table" # the default is table
  end

  def my_friends
    @friends = current_user.friends
  end
  
  def show
    if @user.blank?
      flash[:danger] = "User does not exist."
    end
  end

  private
  def set_user
    if User.exists?(id: params[:id])
      @user = User.find(params[:id])
    end
  end
  
end