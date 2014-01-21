class DiscussionsController < ApplicationController
	before_action :set_disc, only: [:edit, :update, :show,:destroy, :addlike]

	def index
		@discussions=Discussion.order ("hits DESC")
	end
	
	def new
		@discus=Discussion.new
	end

	def create
		@discus=Discussion.new params.require(:discussion).permit([:title,:description])
		if @discus.save
			redirect_to discussions_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @discus.update_attributes params.require(:discussion).permit([:title,:description])
			redirect_to discussions_path
		else
			render :edit
		end
	end

	def show
		@discus.hits||=0
		@discus.hits+=1
		@discus.save
	end

	def destroy 
		@discus.destroy
		redirect_to discussions_path
	end
	private

	def set_disc
		@discus=Discussion.find(params[:id])
	end
end