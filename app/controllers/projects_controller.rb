class ProjectsController < ApplicationController
	before_action :set_proj, only: [:edit, :update, :show,:destroy, :addlike]
	before_action :print_id, except: [:new, :index]
	before_action :boot_out, only: [:edit,:update,:create,:new,:destroy,:addlike]

	def index
		# elders=Project.order("created_at DESC")[3..-1]
		# elders||=[]
		@projects=Project.nmostrs(5)
		# @projects=[]
		# projs.each do |proj|
		# 	if elders.include? proj
		# 		@projects.push proj
		# 	end
		# end
		@recent_projs=Project.order("created_at DESC")[0..2]
		ids=[]
		@recent_projs.each do |rec|
			ids << rec[:id]
		end

		# ids=@recent_projs["Project"][:id]
		# @projects=@projects.select{|x| !ids.include?(x[:id])}
		# @recent_projs.each do |del|
		# 	@projects.delete(del)
		# end
	end
	
	def new
		@proj=Project.new
	end

	def create

		@proj=Project.new params.require(:project).permit([:title,:description,:terms,{category_ids:[]}])
		print @proj
		#@proj.terms=params[:terms]
		#p @proj
		if @proj.save
			print @proj
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
		if @proj.update_attributes params.require(:project).permit([:title,:description,{category_ids:[]}])
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

	def favorites
	end

	def login
		session[:loggedin]='true'
		redirect_to :back
	end

	def logout
		session[:loggedin]='false'
		redirect_to projects_path
	end


	private

	def boot_out
		if session[:loggedin]!='true'
			redirect_to projects_path, alert: "You have to be logged in"
		end
	end

	def print_id
		Rails.logger.info "------------"
		Rails.logger.info params[:id]
		Rails.logger.info "------------"
	end
	
	def set_proj 
		@proj=Project.find(params[:id])
	end
end