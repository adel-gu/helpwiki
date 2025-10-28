class AddUserDetails < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :workspace, null: false, foreign_key: true
    add_column :users, :role, :integer
    add_column :users, :full_name, :string
  end
end
