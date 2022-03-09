class App::Pages::ActiveProjectController < ApplicationController
  before_action :set_active_menu
  before_action :set_project
  before_action :authorize_member
  before_action :set_member, only: [:edit_member, :show_member, :update_member]

  layout 'app'

  def dashboard
    @active_submenu = 'dashboard'
  end

  def edit_member
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def members
    @active_submenu = 'members'
    @members = @project.members.not_refused
  end

  def show_member; end

  def update_member
    if @member.update(member_params)
      flash[:notice] = t('shared.success')
      redirect_to app_project_members_path(@project)
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_member
    return if current_user.admin? || @project.member?(current_user.profile&.id)
 
    flash[:alert] = t('shared.error')
    redirect_to app_project_path(@project)
  end

  def authorize_project
    authorize :project
  end

  def member_params
    params.require(:member).permit(:status, :role)
  end

  def set_active_menu
    @active_menu = 'projects'
  end

  def set_member
    @member = @project.members.where(id: params[:member_id]).last
  end

  def set_project
    @project = Project.find(params[:id] || params[:project_id])
  end
end
