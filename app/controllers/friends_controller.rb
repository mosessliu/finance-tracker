class FriendsController < ApplicationController

  def search
    name = params[:friend_name]
    name_array = name.gsub(/\s+/m, ' ').strip.split(" ")
    @search_results = []

    case name_array.count
    when 0
    when 1
      User.where(first_name: name_array[0]).find_each do |user|
        @search_results.push(user)
      end
      User.where(last_name: name_array[0]).find_each do |user|
        @search_results.push(user)
      end
    else
      User.where(first_name: name_array[0], last_name: name_array[1]).find_each do |user|
        @search_results.push(user)
      end
      User.where(first_name: name_array[1], last_name: name_array[0]).find_each do |user|
        @search_results.push(user)
      end
    end
    flash.now[:success] = "These are your matches."
    respond_to do |format|
      format.js {render partial: 'friends/results.js'}
    end
  end
  
  def create
  end

  def destroy
  end
end