class LeaderboardGenre < ActiveRecord::Base
	# has_many :genress
	serialize :ranklist,Array
end
