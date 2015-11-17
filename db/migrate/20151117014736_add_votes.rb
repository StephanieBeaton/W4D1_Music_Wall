class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :track
      t.belongs_to :user
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
