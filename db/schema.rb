# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170215220414) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "admin_users_roles", id: false, force: :cascade do |t|
    t.integer "admin_user_id", limit: 4
    t.integer "role_id",       limit: 4
  end

  add_index "admin_users_roles", ["admin_user_id", "role_id"], name: "index_admin_users_roles_on_admin_user_id_and_role_id", using: :btree

  create_table "buyers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "phone",      limit: 255
    t.string   "address",    limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "slug",               limit: 255
    t.integer  "views",              limit: 4,   default: 0
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "letsencrypt_plugin_challenges", force: :cascade do |t|
    t.text     "response",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "letsencrypt_plugin_settings", force: :cascade do |t|
    t.text     "private_key", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "marvels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "price",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "priority",           limit: 4
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "buyer_id",        limit: 4
    t.integer  "product_id",      limit: 4
    t.string   "code",            limit: 255
    t.string   "detail",          limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "order_status_id", limit: 4
    t.string   "tracking_title",  limit: 255
    t.integer  "payment",         limit: 4
    t.string   "color",           limit: 255
  end

  add_index "orders", ["buyer_id"], name: "index_orders_on_buyer_id", using: :btree
  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
  add_index "orders", ["product_id"], name: "index_orders_on_product_id", using: :btree

  create_table "page_images", force: :cascade do |t|
    t.string   "caption",              limit: 255
    t.integer  "page_id",              limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id",           limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
  end

  create_table "product_rows", force: :cascade do |t|
    t.integer  "quantity",         limit: 4, default: 1
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "product_id",       limit: 4
    t.integer  "products_list_id", limit: 4
  end

  add_index "product_rows", ["product_id"], name: "fk_rails_cf1216850a", using: :btree
  add_index "product_rows", ["products_list_id"], name: "index_product_rows_on_products_list_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.float    "price",              limit: 24
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "slug",               limit: 255
    t.integer  "category_id",        limit: 4
    t.integer  "views",              limit: 4,     default: 0
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "products_lists", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "user_contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "password_salt",          limit: 32
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "orders", "buyers"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "products"
  add_foreign_key "product_rows", "products"
  add_foreign_key "product_rows", "products_lists"
  add_foreign_key "products", "categories"
end
