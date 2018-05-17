class Stock < ApplicationRecord

  def self.get_stock_from_ticker(ticker)
    hash = StockQuote::Stock.quote(ticker)
    if hash
      return new(ticker: ticker, name: hash.company_name, last_price: hash.latest_price)
    end
  end
end
