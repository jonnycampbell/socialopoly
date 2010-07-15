class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :twitter_id
      t.string :username
      t.string :avatar_url
      t.integer :followers
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
