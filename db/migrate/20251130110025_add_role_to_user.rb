class AddRoleToUser < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :role, :string, null: false, default: 'normal'
    execute("UPDATE users SET role = 'normal' WHERE role IS NULL")
  end

  def down
    remove_comun :users, :role
  end
end
