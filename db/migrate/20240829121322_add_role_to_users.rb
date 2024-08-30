class AddRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :string, default: "subscriber"
  end
end