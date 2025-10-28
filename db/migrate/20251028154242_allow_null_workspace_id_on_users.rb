class AllowNullWorkspaceIdOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :workspace_id, true
  end
end
