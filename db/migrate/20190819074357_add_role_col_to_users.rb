class AddRoleColToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string
    add_column :users, :is_admin, :boolean
    add_column :users, :is_active, :boolean
  end
end
