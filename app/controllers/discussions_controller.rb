class DiscussionsController < ApplicationController

	def index
		@discussions=Discussion.all
	end
	
	def new
		@discus=Discussion.new
	end

	def create
		@discus=Discussion.new params.require(:discussion).permit([:title,:description])
		@discus.save
		redirect_to discussions_path
	end

	def edit
		@discus=Discussion.find(params[:id])
	end

	def update
		@discus=Discussion.find(params[:id])
		@discus.title=params[:discussion][:title]
		@discus.description=params[:discussion][:description]
		@discus.save
		redirect_to discussion_path
	end

	def show
		@discus=Discussion.find(params[:id])
	end

	def destroy 
		@discus=Discussion.find(params[:id])
		@discus.destroy
		redirect_to discussions_path
	end

end