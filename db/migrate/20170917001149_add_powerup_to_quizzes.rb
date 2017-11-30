class AddPowerupToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :powerup, :boolean
  end
end
