class Project < ActiveRecord::Base
	attr_accessor :terms

	validates_presence_of :title, message: "should be provided."
	validates_uniqueness_of :title, message: "should be unique."
	validates :title, length: {minimum: 10, message: "should be at least 10 characters."}
	validates :description, presence: true
	validates :terms, acceptance: {accept: 'does',message: "must be accepted."}
end
