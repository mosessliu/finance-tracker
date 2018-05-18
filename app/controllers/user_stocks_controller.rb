class UserStocksController < ApplicationController 

  def create
    user = User.find(params[:user])
    @ticker = params[:ticker]
    # don't let user add stock if already has in portfolio
    if user_does_not_track_stock? && user.under_stock_limit?
      stock = get_stock_from_ticker
      UserStock.create(user: user, stock: stock)
      flash[:success] = "You have successfully added #{@ticker} to your portfolio."
      redirect_to my_portfolio_path
    end
  end

  def destroy
    UserStock.find_by(user_id: current_user.id, stock_id: params[:id]).destroy
    respond_to do |format|  
      flash.now[:danger] = "You have successfully removed #{@ticker} to your portfolio."
      format.js {render partial: 'users/stocks_index.js'}
    end
  end

  private 
  def user_does_not_track_stock?
    return current_user.stocks.find_by(ticker: @ticker).blank?
  end

  def get_stock_from_ticker
    stock = Stock.find_by ticker: @ticker # try to find stock in table
    if stock.blank?
        stock = Stock.get_stock_from_ticker(@ticker)
    end
    return stock
  end
end