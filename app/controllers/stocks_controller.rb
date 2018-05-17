class StocksController < ApplicationController

  def search
    if !params[:ticker].blank?
      @stock = Stock.get_stock_from_ticker(params[:ticker])
      if !@stock
        flash.now[:danger] = "The ticker symbol you entered is invalid."     
      end
      respond_to do |format|
        format.js {render partial: 'users/result.js'}
      end
    end
  end

end