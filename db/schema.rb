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

ActiveRecord::Schema.define(version: 20170908134633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cabins", force: :cascade do |t|
    t.integer "number", default: 0
    t.bigint "session_id"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_cabins_on_session_id"
  end

  create_table "campers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counselors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enf_classes", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_enf_classes_on_session_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.bigint "session_counselor_id"
    t.bigint "enf_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enf_class_id"], name: "index_instructors_on_enf_class_id"
    t.index ["session_counselor_id"], name: "index_instructors_on_session_counselor_id"
  end

  create_table "session_campers", force: :cascade do |t|
    t.bigint "camper_id"
    t.bigint "cabin_id"
    t.bigint "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cabin_id"], name: "index_session_campers_on_cabin_id"
    t.index ["camper_id"], name: "index_session_campers_on_camper_id"
    t.index ["session_id"], name: "index_session_campers_on_session_id"
  end

  create_table "session_counselors", force: :cascade do |t|
    t.bigint "session_id"
    t.bigint "cabin_id"
    t.bigint "counselor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cabin_id"], name: "index_session_counselors_on_cabin_id"
    t.index ["counselor_id"], name: "index_session_counselors_on_counselor_id"
    t.index ["session_id"], name: "index_session_counselors_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "number"
    t.date "start"
    t.date "finish"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.bigint "session_camper_id"
    t.bigint "enf_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enf_class_id"], name: "index_students_on_enf_class_id"
    t.index ["session_camper_id"], name: "index_students_on_session_camper_id"
  end

  create_table "trip_campers", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "session_camper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_camper_id"], name: "index_trip_campers_on_session_camper_id"
    t.index ["trip_id"], name: "index_trip_campers_on_trip_id"
  end

  create_table "trip_counselors", force: :cascade do |t|
    t.bigint "session_counselor_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_counselor_id"], name: "index_trip_counselors_on_session_counselor_id"
    t.index ["trip_id"], name: "index_trip_counselors_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "description"
    t.string "destination"
    t.boolean "requires_food"
    t.boolean "requires_gear"
    t.bigint "session_counselor_id"
    t.bigint "session_id"
    t.string "trip_group_type"
    t.bigint "trip_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_counselor_id"], name: "index_trips_on_session_counselor_id"
    t.index ["session_id"], name: "index_trips_on_session_id"
    t.index ["trip_group_type", "trip_group_id"], name: "index_trips_on_trip_group_type_and_trip_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.bigint "counselor_id"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["counselor_id"], name: "index_users_on_counselor_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
