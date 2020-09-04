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

ActiveRecord::Schema.define(version: 20_200_827_150_731) do
  create_table 'categoies', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'images', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.string 'link'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_id'], name: 'index_images_on_tour_id'
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.integer 'user_id', null: false
    t.text 'content'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'picture'
    t.index ['tour_id'], name: 'index_reviews_on_tour_id'
    t.index ['user_id'], name: 'index_reviews_on_user_id'
  end

  create_table 'tour_details', force: :cascade do |t|
    t.integer 'tour_id', null: false
    t.date 'departure_time'
    t.date 'return_time'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tour_id'], name: 'index_tour_details_on_tour_id'
  end

  create_table 'tours', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'price'
    t.integer 'category_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'seats'
    t.integer 'coupon'
    t.index ['category_id'], name: 'index_tours_on_category_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.boolean 'admin', default: false
    t.integer 'coin', default: 0
    t.string 'provider'
    t.string 'uid'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'images', 'tours'
  add_foreign_key 'reviews', 'tours'
  add_foreign_key 'reviews', 'users'
  add_foreign_key 'tour_details', 'tours'
  add_foreign_key 'tours', 'categories'
end
