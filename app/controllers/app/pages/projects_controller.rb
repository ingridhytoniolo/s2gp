class App::Pages::ProjectsController < ApplicationController
  require 'mini_magick'
  require 'image_processing/mini_magick'

  before_action :authenticate_user!
  before_action :authorize_project
  before_action :set_active_menu
  before_action :set_project, only: [:show, :edit, :update, :join]
  before_action :authorize_member, only: [:dashboard]

  layout 'app'

  def index
    @projects = Project.by_status
  end

  def show; end

  def new
    @project = Project.new
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    resize_avatar
    update_params
  
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = t('shared.success')
      redirect_to app_projects_path
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    resize_avatar
    update_params

    if @project.update(project_params)
      flash[:notice] = t('shared.success')
      redirect_to app_project_path(@project)
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def join
    if @project.can_join?(current_user.profile.id)
      member = @project.members.new(profile_id: current_user.profile.id)

      if member.save
        flash[:notice] = t('shared.success')
      else
        flash[:alert] = t('shared.error')
      end
    else
      flash[:alert] = t('shared.error')
    end

    redirect_to request.referer
  end

  private

  def authorize_member
    return if current_user.admin? || @project.researcher?(current_user.profile.id)
 
    flash[:alert] = t('shared.error')
    redirect_to app_project_path(@project)
  end

  def authorize_project
    authorize :project
  end

  def project_params
    params.require(:project).permit(:status, :avatar, :title, :main_goal, :description, :start_at, :end_at)
  end

  def resize_avatar
    return unless project_params['avatar']

    acceptable_types = ['image/jpeg', 'image/png']
    return unless acceptable_types.include?(project_params['avatar'].content_type)

    temp_path = project_params['avatar'].tempfile.path

    image = MiniMagick::Image.open(temp_path)
    image.resize '640x640'
    image.write temp_path
  end

  def set_active_menu
    @active_menu = 'projects'
  end

  def set_project
    @project = Project.find(params[:id] || params[:project_id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_projects_path(@project)
  end

  def update_params
    params['project']['start_at'] = Date.strptime(params['project']['start_at'], '%m/%Y') if params['project']['start_at'].present?
    params['project']['end_at'] = Date.strptime(params['project']['end_at'], '%m/%Y') if params['project']['end_at'].present?
  end
end
