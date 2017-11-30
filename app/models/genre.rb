class Genre < ActiveRecord::Base
  has_many :subgenres 
  belongs_to :leaderboard_genre

end
