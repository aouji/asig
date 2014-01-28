module ApplicationHelper
	# before_action :authenticate_user!, only: [:current_users_vote,:current_user_voted]

	def truncate_s(input,len)
		input.truncate(len,omission: ".....!")
	end


	def user_upped(proj)
		proj.current_user_voted && proj.current_users_vote=='up'
	end

	def user_downed(proj)
		proj.current_user_voted && proj.current_users_vote=='down'
	end

	private

	def current_users_vote
		authenticate_user!
		votes.find_by(user_id: current_user).vote_kind
	end

	def current_user_voted
		authenticate_user!
		voters.include? current_user
	end
end
