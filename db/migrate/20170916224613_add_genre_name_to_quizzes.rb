class AddGenreNameToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :genre_name, :string
  end
end
