# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_241_115_163_623) do
  create_table 'categories', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_categories_on_user_id'
  end

  create_table 'tags', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_tags_on_user_id'
  end

  create_table 'tags_tasks', id: false, charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'tag_id', null: false
    t.bigint 'task_id', null: false
    t.index %w[tag_id task_id], name: 'index_tags_tasks_on_tag_id_and_task_id'
    t.index %w[task_id tag_id], name: 'index_tags_tasks_on_task_id_and_tag_id'
  end

  create_table 'task_user_assignments', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'task_id', null: false
    t.bigint 'user_id', null: false
    t.string 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[task_id user_id], name: 'index_task_user_assignments_on_task_id_and_user_id'
    t.index ['task_id'], name: 'index_task_user_assignments_on_task_id'
    t.index %w[user_id task_id], name: 'index_task_user_assignments_on_user_id_and_task_id'
    t.index ['user_id'], name: 'index_task_user_assignments_on_user_id'
  end

  create_table 'tasks', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.integer 'position', null: false
    t.boolean 'completed', default: false, null: false
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_tasks_on_category_id'
  end

  create_table 'users', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'categories', 'users'
  add_foreign_key 'tags', 'users'
  add_foreign_key 'task_user_assignments', 'tasks'
  add_foreign_key 'task_user_assignments', 'users'
  add_foreign_key 'tasks', 'categories'
end
