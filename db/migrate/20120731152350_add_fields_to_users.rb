class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :salutation, :string
    add_column :users, :title, :string
  end
end
