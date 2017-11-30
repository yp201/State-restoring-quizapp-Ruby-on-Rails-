class AddFiftyFiftyToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :fifty_fifty, :boolean, :default:true
  end
end
