class Question < ActiveRecord::Base
	serialize :options,Array
	serialize :answer,Array
	belongs_to :subgenre
end
