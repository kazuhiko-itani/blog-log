class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :memo
      t.date :date
      t.integer :working_total

      t.timestamps
    end
    add_index :posts, [:user_id, :date]
  end
end
