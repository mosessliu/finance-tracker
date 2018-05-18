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
    stock = Stock.find(params[:id])
    UserStock.find_by(user_id: current_user.id, stock_id: params[:id]).destroy
    flash.now[:danger] = "You have successfully removed #{stock.ticker} from your portfolio."
    respond_to do |format|
      if params[:display_style] == 'cards'
        format.js {render partial: 'users/stocks_cards.js'}
      elsif params[:display_style] == 'table'
        format.js {render partial: 'users/stocks_table.js'}
      end
    end
  end

  def change_portfolio_display_style
    respond_to do |format|
      if params[:display_style] == 'cards'
        format.js {render partial: 'users/stocks_cards.js'}
      elsif params[:display_style] == 'table'
        format.js {render partial: 'users/stocks_table.js'}
      end
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

  def respond_with_cards_or_table(format)
    if params[:display_style] == 'cards'
      format.js {render partial: 'users/stocks_cards.js'}
    elsif params[:display_style] == 'table'
      format.js {render partial: 'users/stocks_table.js'}
    end
  end
end