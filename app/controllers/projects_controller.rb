class ProjectsController < ApplicationController
  def create
    @action = CreatesProject.new(
                name: params[:project][:name],
                task_string: params[:project][:tasks])
    success = @action.create
    if success
      redirect_to projects_path
    else
      @project = @action.project
      render :new
    end
  end

  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end
end
