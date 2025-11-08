class AddWorkspaceToActivityLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :activity_logs, :workspace, null: false, foreign_key: true
  end
end
