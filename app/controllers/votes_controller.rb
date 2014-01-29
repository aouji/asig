class VotesController < ApplicationController
before_action :authenticate_user!, only: [:create,:remove]#,:update,:destroy]
before_action :findproj, only: [:create,:remove]

  def create
    if (current_user.voted_projects.include? @proj)
      changevote
    else
      addvote 
    end
  end

  def remove
    if (current_user.voted_projects.include? @proj)
      current_vote=current_user.votes.find_by(project_id: @proj)
      if (params[:vote]=='upback' && current_vote.vote_kind=='up')
        @proj.vote_count-=1
      elsif (params[:vote]=='downback' && current_vote.vote_kind=='down')
        @proj.vote_count+=1
      else
        redirect_to project_path(@proj), alert: "Something's not right."
      end
      current_user.voted_projects.delete @proj
      @proj.save
      redirect_to project_path(@proj), notice: "Vote removed."
    else
      redirect_to project_path(@proj), alert: "You have not voted yet."
    end
  end

  private

  def addvote
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
      savevote vote
  end

  def changevote
      current_vote=current_user.votes.find_by(project_id: @proj)
      if (params[:vote]=='up' && current_vote.vote_kind=='down')
        current_vote.vote_kind='up'
        @proj.vote_count+=2
        savevote current_vote
      elsif (params[:vote]=='down' && current_vote.vote_kind=='up')
        current_vote.vote_kind='down'
        @proj.vote_count-=2
        savevote current_vote
      else
		    redirect_to project_path(@proj), alert: "Something's not right."
      end
  end

  def savevote vote
    vote.save
    @proj.save
    redirect_to project_path(@proj)
  end

  def findproj
    @proj=Project.find(params[:project_id])
  end

end
