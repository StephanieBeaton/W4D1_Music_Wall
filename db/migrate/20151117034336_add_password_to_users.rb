class AddPasswordToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :password
    end

    def down
      remove_column :password
    end
  end
end
