class App::Pages::ActiveProject::MembersController < App::Pages::ActiveProjectController
  before_action :set_member, only: [:show, :edit, :update]

  layout 'app'

  def create
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

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def index
    @members = @project.members.by_name
  end

  def new
    @member = Member.new

    current_members_profiles_ids = @project.members.pluck(:profile_id)
    @profiles = Profile.where.not(id: current_members_profiles_ids).where.not(name: nil).map {|p| ["#{p.name} - #{p.user.email}", p.id]}
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def show
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
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

  private

  def member_params
    params.require(:member).permit(:profile_id, :role, :status)
  end

  def set_member
    @member = @project.members.find(params[:id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_project_members_path(@project)
  end
end
