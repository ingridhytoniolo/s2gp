class App::Pages::ActiveProjectController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_menu
  before_action :set_project
  before_action :authorize_member

  private

  def authorize_member
    set_project

    return if current_user.admin? || @project.member?(current_user.profile&.id)
 
    flash[:alert] = t('shared.error')
    redirect_to app_project_path(@project)
  end

  def set_active_menu
    @active_menu = 'projects'
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end
end
