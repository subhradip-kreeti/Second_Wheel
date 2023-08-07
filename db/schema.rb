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

ActiveRecord::Schema.define(version: 20_230_728_101_412) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'appointments', force: :cascade do |t|
    t.date 'date', null: false
    t.bigint 'user_id', null: false
    t.string 'status'
    t.bigint 'car_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'appointment_id'
    t.index ['car_id'], name: 'index_appointments_on_car_id'
    t.index ['user_id'], name: 'index_appointments_on_user_id'
  end

  create_table 'branches', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'address', null: false
    t.string 'map_link', null: false
    t.string 'longitude', null: false
    t.string 'latitude', null: false
    t.bigint 'city_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['city_id'], name: 'index_branches_on_city_id'
  end

  create_table 'brands', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['name'], name: 'index_brands_on_name', unique: true
  end

  create_table 'car_models', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'brand_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['brand_id'], name: 'index_car_models_on_brand_id'
    t.index ['name'], name: 'index_car_models_on_name', unique: true
  end

  create_table 'cars', force: :cascade do |t|
    t.string 'condition'
    t.bigint 'brand_id', null: false
    t.bigint 'car_model_id', null: false
    t.bigint 'user_id', null: false
    t.bigint 'branch_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'variant', null: false
    t.string 'kilometer_driven', null: false
    t.string 'reg_year', null: false
    t.string 'reg_state', null: false
    t.string 'image'
    t.string 'price'
    t.string 'selling_appointment_status'
    t.string 'reg_no', null: false
    t.index ['branch_id'], name: 'index_cars_on_branch_id'
    t.index ['brand_id'], name: 'index_cars_on_brand_id'
    t.index ['car_model_id'], name: 'index_cars_on_car_model_id'
    t.index ['reg_no'], name: 'index_cars_on_reg_no', unique: true
    t.index ['user_id'], name: 'index_cars_on_user_id'
  end

  create_table 'cities', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'state', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'notifications', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.text 'message', null: false
    t.boolean 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.string 'role', null: false
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'is_verified', default: false
    t.string 'token_expire'
    t.string 'name', null: false
    t.string 'mobile_no', null: false
    t.float 'latitude'
    t.float 'longitude'
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'appointments', 'cars'
  add_foreign_key 'appointments', 'users'
  add_foreign_key 'branches', 'cities'
  add_foreign_key 'car_models', 'brands'
  add_foreign_key 'cars', 'branches'
  add_foreign_key 'cars', 'brands'
  add_foreign_key 'cars', 'car_models'
  add_foreign_key 'cars', 'users'
  add_foreign_key 'notifications', 'users'
end
