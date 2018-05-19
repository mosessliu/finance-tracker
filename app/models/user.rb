class User < ApplicationRecord

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def under_stock_limit?
    return stocks.count < 9;
  end

  def full_name
    if has_name
      return "#{first_name} #{last_name}" 
    else
      return nil
    end
  end

  private 
  def has_name
    return first_name || last_name
  end

end
