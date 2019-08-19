class RemoveColumns < ActiveRecord::Migration[5.2]
 	def self.up
    remove_column :users, :access_token, :string
   	remove_column :users, :refresh_token, :string
   	remove_column :users, :expirea_at, :string
  end

  def self.down
    add_column :users, :access_token, :string
   	add_column :users, :refresh_token, :string
   	add_column :users, :expirea_at, :string
  end
end
