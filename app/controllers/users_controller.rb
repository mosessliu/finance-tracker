class UsersController < ApplicationController 
  
  def my_portfolio
    params[:display_style] = "table"
  end

  def my_friends
    @friends = current_user.friends
  end
  
end