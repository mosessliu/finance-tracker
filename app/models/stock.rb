class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.get_stock_from_ticker(ticker)
    hash = StockQuote::Stock.quote(ticker)
    if hash
      return new(ticker: ticker, name: hash.company_name, last_price: hash.latest_price)
    end
  end

  #method assumes that stock already exists
  def updated_last_price
    return StockQuote::Stock.quote(self.ticker).latest_price
  end
end
