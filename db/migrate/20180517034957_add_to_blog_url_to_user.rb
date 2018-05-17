class AddToBlogUrlToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :blog_url, :string
  end
end
