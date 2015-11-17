class AddTracks2 < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :song_title
      t.string :author
      t.string :url
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

  end
end
