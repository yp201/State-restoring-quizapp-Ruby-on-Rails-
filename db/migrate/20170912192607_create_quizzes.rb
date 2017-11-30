class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :user_id
      t.string :genre_id
      t.string :subgenre_id
      t.integer :score
      t.boolean :ongoing
      t.integer :current_question

      t.timestamps null: false
    end
  end
end
