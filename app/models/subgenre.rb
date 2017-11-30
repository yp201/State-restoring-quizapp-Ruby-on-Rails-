class Subgenre < ActiveRecord::Base
	has_many :questions
	belongs_to :genre
end
