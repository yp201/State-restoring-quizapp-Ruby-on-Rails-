class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :subgenre_id
      t.text :question
      t.text :options
      t.text :answer

      t.timestamps null: false
    end
  end
end
