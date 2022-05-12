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

ActiveRecord::Schema.define(version: 2022_04_25_081140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "content"
    t.boolean "is_correct_answer", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name"
    t.string "time_limit"
    t.integer "pass_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "history_do_exams", force: :cascade do |t|
    t.string "answer"
    t.integer "amount_test", default: 0
    t.bigint "user_id"
    t.bigint "question_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_history_do_exams_on_question_id"
    t.index ["user_id"], name: "index_history_do_exams_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "exam_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id"], name: "index_questions_on_exam_id"
  end

  create_table "user_exams", force: :cascade do |t|
    t.bigint "exam_id", null: false
    t.bigint "user_id", null: false
    t.integer "total_score"
    t.time "completed_time"
    t.boolean "is_passed", default: false
    t.integer "total_test"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id"], name: "index_user_exams_on_exam_id"
    t.index ["user_id"], name: "index_user_exams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "history_do_exams", "questions"
  add_foreign_key "history_do_exams", "users"
  add_foreign_key "questions", "exams"
  add_foreign_key "user_exams", "exams"
  add_foreign_key "user_exams", "users"
end
