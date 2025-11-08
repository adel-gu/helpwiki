class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :task_title
      t.text :task_description
      t.integer :status
      t.integer :priority
      t.datetime :due_date
      t.string :title
      t.string :slug
      t.datetime :published_at
      t.references :workspace, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.references :creator, foreign_key: { to_table: :users }
      t.references :writer, foreign_key: { to_table: :users }
      t.references :reviewer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
