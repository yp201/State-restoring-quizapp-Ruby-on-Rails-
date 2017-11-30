class CreateLeaderboardGenres < ActiveRecord::Migration
  def change
    create_table :leaderboard_genres do |t|
      t.string :genre_id
      t.text :ranklist

      t.timestamps null: false
    end
  end
end
