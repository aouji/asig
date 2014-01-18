class ProjectsController < ApplicationController

	def index
		@projects=Project.all
	end
	
	def new
		@proj=Project.new
	end

	def create
		@proj=Project.new params.require(:project).permit([:title,:description])
		@proj.save
		redirect_to projects_path
	end

	def edit
			@proj=Project.find(params[:id])
	end

	def update
		@proj=Project.find(params[:id])
		@proj.title=params[:project][:title]
		@proj.description=params[:project][:description]
		@proj.save
		redirect_to project_path
	end

	def show
		@proj=Project.find(params[:id])
	end

	def destroy 
		@proj=Project.find(params[:id])
		@proj.destroy
		redirect_to projects_path
	end

	def addlike
		par_id=params[:id]
		proj = Project.find(par_id)
		if session[:likes] != nil
			session[:likes].each do |id|
				if par_id==id
					redirect_to project_path
					return
				end
			end
		else
			session[:likes]=Array.new
		end
		session[:likes].push(par_id)
	  proj.like+=1
	  proj.save
	  redirect_to project_path
	end
end