class CreateArticleVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :article_versions do |t|
      t.references :article, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :content

      t.timestamps
    end
  end
end
