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

ActiveRecord::Schema.define(version: 2023_10_29_233119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gin"
  enable_extension "btree_gist"
  enable_extension "citext"
  enable_extension "cube"
  enable_extension "dblink"
  enable_extension "dict_int"
  enable_extension "dict_xsyn"
  enable_extension "earthdistance"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "intarray"
  enable_extension "ltree"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "pgrowlocks"
  enable_extension "pgstattuple"
  enable_extension "plpgsql"
  enable_extension "tablefunc"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"
  enable_extension "xml2"

  create_table "codes", force: :cascade do |t|
    t.string "code"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_codes_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "nit"
    t.string "razon_social"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rut"
    t.integer "users_count"
    t.string "avatar"
  end

  create_table "dispatches", force: :cascade do |t|
    t.string "ruta"
    t.time "horario"
    t.boolean "switch"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "numero_factura"
    t.string "mes_factura"
    t.string "factura"
    t.string "certificacion"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_invoices_on_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "fecha"
    t.integer "consecutivo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.string "destino"
    t.string "origen"
    t.string "estado", default: "En espera"
    t.string "codigo_envio"
    t.decimal "valor"
    t.bigint "dispatch_id"
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["dispatch_id"], name: "index_orders_on_dispatch_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packs", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "tipo"
    t.string "cantidad"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_packs_on_order_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "title"
    t.string "name"
    t.string "subject"
    t.string "email"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "estado", default: "En espera"
  end

  create_table "responses", force: :cascade do |t|
    t.text "content"
    t.bigint "request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rol", default: "U"
    t.index ["request_id"], name: "index_responses_on_request_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nombre"
    t.string "apellido"
    t.boolean "admin"
    t.string "avatar"
    t.string "token"
    t.boolean "first_login"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "codes", "users"
  add_foreign_key "invoices", "companies"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "dispatches"
  add_foreign_key "orders", "users"
  add_foreign_key "packs", "orders"
  add_foreign_key "responses", "requests"
end
