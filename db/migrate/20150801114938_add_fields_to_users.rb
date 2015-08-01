class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact, :string
    add_column :users, :location, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
