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

ActiveRecord::Schema.define(version: 2019_01_14_172701) do

  create_table "answer_votes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "answer_id"
    t.integer "up_down_score", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "fk_rails_e53de8bac5"
    t.index ["user_id"], name: "fk_rails_dbe100e17a"
  end

  create_table "answers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.text "description"
    t.integer "up_vote_count"
    t.integer "down_vote_count"
    t.binary "status", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "fk_rails_3d5ed4418f"
    t.index ["user_id"], name: "fk_rails_584be190c2"
  end

  create_table "question_accesses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "team_id"
    t.binary "answer_access", limit: 1, null: false
    t.binary "vote_access", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "fk_rails_d98bfbec85"
    t.index ["team_id"], name: "fk_rails_5a493006c3"
  end

  create_table "question_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "fk_rails_e6a38f5c87"
    t.index ["tag_id"], name: "fk_rails_38e4cf053b"
  end

  create_table "question_votes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.integer "up_down_vote", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "fk_rails_974ab16b14"
    t.index ["user_id"], name: "fk_rails_7831827660"
  end

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.string "subject"
    t.text "description"
    t.integer "ans_upvote_score", limit: 2
    t.integer "ans_downvote_score", limit: 2
    t.binary "status_codes_id", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_codes_id"], name: "status_codes_id"
    t.index ["team_id"], name: "fk_rails_c28fcf9c45"
    t.index ["user_id"], name: "fk_rails_047ab75908"
  end

  create_table "site_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_codes", id: :binary, limit: 2, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_admins", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "fk_rails_7eb5133fd9"
    t.index ["user_id"], name: "fk_rails_b678359897"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "fk_rails_64c25f3fe6"
    t.index ["user_id"], name: "fk_rails_978858c8ea"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answer_votes", "answers"
  add_foreign_key "answer_votes", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "question_accesses", "questions"
  add_foreign_key "question_accesses", "teams"
  add_foreign_key "question_tags", "questions"
  add_foreign_key "question_tags", "tags"
  add_foreign_key "question_votes", "questions"
  add_foreign_key "question_votes", "users"
  add_foreign_key "questions", "status_codes", column: "status_codes_id", name: "questions_ibfk_1"
  add_foreign_key "questions", "teams"
  add_foreign_key "questions", "users"
  add_foreign_key "team_admins", "teams"
  add_foreign_key "team_admins", "users"
  add_foreign_key "user_teams", "teams"
  add_foreign_key "user_teams", "users"
end
