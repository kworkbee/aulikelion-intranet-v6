class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :category
      t.string :title
      t.text :content
      t.text :file
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
