class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.references :workspace, null: false, foreign_key: true
      t.string :name, null: false
      t.references :parent_category, foreign_key: { to_table: :categories }, index: true
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
