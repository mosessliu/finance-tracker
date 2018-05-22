class FriendsController < ApplicationController

  def search_query
  end

  def search_results
    name = params[:friend_name]
    name_array = name.gsub(/\s+/m, ' ').strip.split(" ")
    id = current_user.id
    
    case name_array.count
    when 0
      @search_results = []
    when 1
      @search_results = User.search(name_array[0], id)
    else
      @search_results = (User.search(name_array[0], id) + User.search(name_array[1], id)).uniq
    end

    if @search_results.count == 0
      if name.present?
        flash.now[:warning] = "There are no users named #{name_array.join(" ")}."
      end
    end

    respond_to do |format|
      format.js {render partial: 'friends/results.js'}
    end
  end
  
  def create
    friend_id = params[:friend_id]
    friend = User.find(params[:friend_id])

    if current_user.id == friend_id or current_user.friends.include?(friend)
      flash.now[:danger] = "Friend cannot be added."
    else
      friend = User.find(params[:friend_id])
      Friendship.create(user: current_user, friend: friend)
      flash.now[:success] = "You have added #{friend.full_name} as a friend!"
    end

    respond_to do |format| 
      format.js {render partial: 'friends/results'}
    end
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.delete

    respond_to do |format| 
      format.js {render partial: 'shared/users_grid.js'}
    end
  end

  private 
  def push_to_results(user)
    if current_user.id != user.id
      @search_results.push(user)
    end
  end


end