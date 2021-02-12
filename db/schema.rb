

ActiveRecord::Schema.define(version: 2021_02_10_193659) do

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updates_at"
  end

end
