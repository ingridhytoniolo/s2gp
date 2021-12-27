class ProjectsController < ApplicationController
  def index
    @projects = Project.by_status
  end

  def show
    @project = Project.find(params[:id])
  end
end
