class ProjectsController < ApplicationController
	before_action :set_proj, only: [:edit, :update, :show,:destroy, :addlike]
	def index
		@projects=Project.order ("hits DESC")
		@recent_projs=Project.order("created_at DESC")[0..2]
	end
	
	def new
		@proj=Project.new
	end

	def create
		@proj=Project.new params.require(:project).permit([:title,:description])
		if @proj.save
			redirect_to projects_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		# @proj.title=params[:project][:title]
		# @proj.description=params[:project][:description]
		# @proj.save
		if @proj.update_attributes params.require(:project).permit([:title,:description])
			redirect_to projects_path
		else
			render :edit
		end
	end

	def show
		@proj.hits||=0
		@proj.hits+=1
		@proj.save
	end

	def destroy 
		@proj.destroy
		redirect_to projects_path
	end

	def addlike
		par_id=params[:id]
		session[:likes]||=Array.new
		#if session[:likes] != nil
		if session[:likes].include? par_id
			redirect_to project_path, alert: "You have already liked."
			return
		end
		# (session[:likes].include? par_id)? Proc.new{
		# 	redirect_to project_path, alert: "You have already liked."
		# 	#puts "FEFEFFEFFEFEWFWEFEW"
		# 	return}.call
		# 	: nil
		# 	redirect_to project_path
		# 	return
		# end
			# session[:likes].each do |id|
			# 	if par_id==id
			# 		redirect_to project_path
			# 		return
			# 	end
			# end
		# else
		# 	session[:likes]=Array.new
		# end
		session[:likes].push(par_id)
	  @proj.like+=1
	  @proj.save
	  redirect_to project_path, notice: "Thanks for liking"
	end

	private

	def set_proj 
		@proj=Project.find(params[:id])
	end
end