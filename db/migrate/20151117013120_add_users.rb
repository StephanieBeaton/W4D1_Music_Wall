class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email,        null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
