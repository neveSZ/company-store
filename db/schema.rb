# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_06_224103) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collaborators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.string "social_name"
    t.date "birth_date"
    t.string "role"
    t.string "department"
    t.integer "company_id", null: false
    t.integer "status", default: 0
    t.index ["company_id"], name: "index_collaborators_on_company_id"
    t.index ["email"], name: "index_collaborators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_collaborators_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "domain"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_messages", force: :cascade do |t|
    t.integer "collaborator_id", null: false
    t.string "texto"
    t.string "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collaborator_id"], name: "index_product_messages_on_collaborator_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "category_id", null: false
    t.json "images"
    t.string "description"
    t.string "value"
    t.integer "status", default: 0
    t.integer "product_messages_id"
    t.integer "collaborator_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["collaborator_id"], name: "index_products_on_collaborator_id"
    t.index ["product_messages_id"], name: "index_products_on_product_messages_id"
  end

  add_foreign_key "collaborators", "companies"
  add_foreign_key "product_messages", "collaborators"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "collaborators"
  add_foreign_key "products", "product_messages", column: "product_messages_id"
end
