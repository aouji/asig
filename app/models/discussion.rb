class Discussion < ActiveRecord::Base
	validates_presence_of :title, message: "should be provided."
	validates_uniqueness_of :title, message: "should be unique."
	validates :title, length: {minimum: 10, message: "should be at least 10 characters."}
	validates :description, presence: true
end
