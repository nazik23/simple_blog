class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, limit: 100
      t.text :body, limit: 1000
      t.string :tags

      t.timestamps
    end
  end
end
