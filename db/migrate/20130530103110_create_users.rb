class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :pwd
      t.string :tag
      t.datetime :register_time

      t.timestamps
    end
  end
end
