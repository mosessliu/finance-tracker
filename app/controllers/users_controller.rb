class UsersController < ApplicationController 
  
  def my_portfolio
    params[:display_style] = "table"
  end
  
end