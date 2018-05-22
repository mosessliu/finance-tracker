class User < ApplicationRecord

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic
        
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

  def self.search(params, id)
    params.strip!
    params.downcase!
    to_return = (first_name_matches(params, id) + last_name_matches(params, id) + email_matches(params, id)).uniq
    return to_return
  end

  def self.first_name_matches(params, id)
    return matches("first_name", params, id)
  end

  def self.last_name_matches(params, id)
    return matches("last_name", params, id)
  end

  def self.email_matches(params, id)
    return matches("email", params, id)
  end
  
  private 
  def has_name
    return first_name || last_name
  end

  def self.matches(field, param, id)
    return User.where("#{field} like ? AND id != ?", "%#{param}%", id)
  end

end
