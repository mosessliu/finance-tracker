class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend, class_name: "User", foreign_key: true

      t.timestamps
    end
  end
end