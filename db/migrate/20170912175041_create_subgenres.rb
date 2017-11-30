class CreateSubgenres < ActiveRecord::Migration
  def change
    create_table :subgenres do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
