class CreateAltUsers < ActiveRecord::Migration
  def change
    create_table :alt_users do |t|
      t.string :name
      t.text :flags

      t.timestamps
    end
  end
end
