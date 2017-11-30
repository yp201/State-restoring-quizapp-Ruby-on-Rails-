class CreateLeaderboardSubgenres < ActiveRecord::Migration
  def change
    create_table :leaderboard_subgenres do |t|
      t.string :subgenre_id
      t.text :ranklist

      t.timestamps null: false
    end
  end
end
