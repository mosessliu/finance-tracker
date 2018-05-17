class StocksController < ApplicationController

  def search
    if params[:ticker] && !params[:ticker].empty?
      @stock = Stock.get_stock_from_ticker(params[:ticker])
      if !@stock
        flash[:danger] = "The ticker symbol you entered is invalid."
        render 'users/my_portfolio'
      else 
        respond_to do |format|
          format.js {render partial: 'users/result'}
        end
      end
    else
      render 'users/my_portfolio'
    end
  end
end