class AddTwitterUrlToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :twitter_url, :string
  end
end
