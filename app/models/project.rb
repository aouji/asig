class Project < ActiveRecord::Base
	attr_accessor :terms

	has_many :categorizations, dependent: :destroy
	has_many :categories, through: :categorizations

	scope :hitorder, -> {order('hits DESC')}
	scope :likeorder, -> {order('likes DESC')}
	scope :nmostrs, lambda{|n| order("created_at DESC").limit(n)}
	
	# before_save :cap_it_all
	after_save :print_message
	before_create :cap_it_all

	
	validates_presence_of :title, message: "should be provided."
	validates_uniqueness_of :title, message: "should be unique."
	validates :title, length: {minimum: 10, message: "should be at least 10 characters."}
	validates :description, presence: true
	validates :terms, acceptance: {accept: 'does',message: "must be accepted."}
	private

	def cap_it_all
		self.title.capitalize!
		self.description.capitalize!
	end

	def print_message
		Rails.logger.info "This is a message"
	end

end
