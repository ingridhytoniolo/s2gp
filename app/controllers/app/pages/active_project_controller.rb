class App::Pages::ActiveProjectController < ApplicationController
  before_action :set_active_menu
  before_action :set_project
  before_action :authorize_member
  before_action :set_member, only: [:member_edit, :member_update]

  layout 'app'

  def activities; end

  def dashboard; end

  def meetings; end

  def member_create
    params['member']['status'] = :accepted

    @member = @project.members.new(member_params)

    if @member.save
      flash[:notice] = t('shared.success')
      redirect_to app_project_members_path(@project)
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def member_edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def member_new
    @member = Member.new

    current_members_profiles_ids = @project.members.pluck(:profile_id)
    @profiles = Profile.where.not(id: current_members_profiles_ids).where.not(name: nil).map {|p| ["#{p.name} - #{p.user.email}", p.id]}
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def member_update
    params['member']['status'] = :accepted

    if @member.update(member_params)
      flash[:notice] = t('shared.success')
      redirect_to app_project_members_path(@project)
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def members; end

  def resources; end

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
    params.require(:member).permit(:profile_id, :role, :status)
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
