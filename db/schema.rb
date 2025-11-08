# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_08_162439) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "actor_id", null: false
    t.integer "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["actor_id"], name: "index_activity_logs_on_actor_id"
    t.index ["article_id"], name: "index_activity_logs_on_article_id"
    t.index ["workspace_id"], name: "index_activity_logs_on_workspace_id"
  end

  create_table "article_versions", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "author_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_versions_on_article_id"
    t.index ["author_id"], name: "index_article_versions_on_author_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "task_title"
    t.text "task_description"
    t.integer "status"
    t.integer "priority"
    t.datetime "due_date"
    t.string "title"
    t.string "slug"
    t.datetime "published_at"
    t.bigint "workspace_id", null: false
    t.bigint "category_id"
    t.bigint "creator_id"
    t.bigint "writer_id"
    t.bigint "reviewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["creator_id"], name: "index_articles_on_creator_id"
    t.index ["reviewer_id"], name: "index_articles_on_reviewer_id"
    t.index ["workspace_id"], name: "index_articles_on_workspace_id"
    t.index ["writer_id"], name: "index_articles_on_writer_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "workspace_id", null: false
    t.string "name", null: false
    t.bigint "parent_category_id"
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_categories_on_creator_id"
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
    t.index ["workspace_id"], name: "index_categories_on_workspace_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id"
    t.integer "role"
    t.string "full_name"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["workspace_id"], name: "index_users_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activity_logs", "articles"
  add_foreign_key "activity_logs", "users", column: "actor_id"
  add_foreign_key "activity_logs", "workspaces"
  add_foreign_key "article_versions", "articles"
  add_foreign_key "article_versions", "users", column: "author_id"
  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users", column: "creator_id"
  add_foreign_key "articles", "users", column: "reviewer_id"
  add_foreign_key "articles", "users", column: "writer_id"
  add_foreign_key "articles", "workspaces"
  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "categories", "users", column: "creator_id"
  add_foreign_key "categories", "workspaces"
  add_foreign_key "users", "workspaces"
end
