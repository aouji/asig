class VotesController < ApplicationController
before_action :authenticate_user!, only: [:create,:remove]#,:update,:destroy]

	def create
		@proj=Project.find(params[:project_id])
		if (current_user.voted_projects.include? @proj)
		    redirect_to project_path(@proj), alert: "You have already voted"
		else
			current_user.voted_projects << @proj
			vote=current_user.votes.find_by(project_id: @proj)
			if (params[:vote]=='up')
				@proj.vote_count+=1
				vote.vote_kind='up'
			elsif (params[:vote]=='down')
				@proj.vote_count-=1
				vote.vote_kind='down'
			else
				redirect_to project_path(@proj), alert: "Something's not right."
			end
			vote.save
			@proj.save
			redirect_to project_path(@proj)
		end
	end

	def remove
		@proj=Project.find(params[:project_id])
		if (current_user.voted_projects.include? @proj)
		    current_user.voted_projects.delete @proj
		    if (params[:vote]=='upback')
				@proj.vote_count-=1
			elsif (params[:vote]=='downback')
				@proj.vote_count+=1
			else
				redirect_to project_path(@proj), alert: "Something's not right."
			end
			@proj.save
			redirect_to project_path(@proj), notice: "Vote removed."
		else
			redirect_to project_path(@proj), alert: "You have not voted yet."
		end
	end
end
