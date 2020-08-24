class AddMoreFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :website, :string
    add_column :users, :first_name, :string
  end
end
