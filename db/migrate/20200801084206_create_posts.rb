class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :fee
      t.text :caption
      t.integer :user_id
      t.string :image_id

      t.timestamps
    end
  end
end
