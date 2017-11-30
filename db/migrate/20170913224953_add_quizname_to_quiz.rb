class AddQuiznameToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :quizname, :string
  end
end
