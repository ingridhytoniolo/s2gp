class App::Pages::ActiveProject::ActivitiesController < App::Pages::ActiveProjectController
  before_action :set_activity, only: [:show, :edit, :update]

  layout 'app'

  def create
    update_params

    @activity = @project.activities.new(activity_params.except(:participants))

    if @activity.save
      update_participants

      flash[:notice] = t('shared.success')
      redirect_to app_project_activities_path(@project)
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def edit
    @current_profile_ids = @activity.participants.pluck(:profile_id)

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def index
    @activities = @project.activities.order_by_status.order_by_priority.order(:start_at)
  end

  def new
    @activity = Activity.new

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
    update_params

    if @activity.update(activity_params.except(:participants))
      update_participants

      flash[:notice] = t('shared.success')
      redirect_to app_project_activities_path(@project)
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:description, :end_at, :priority, :start_at, :status, participants: {})
  end

  def set_activity
    @activity = @project.activities.find(params[:id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_project_activities_path(@project)
  end

  def update_params
    params['activity']['start_at'] = Date.strptime(params['activity']['start_at'], '%d/%m/%Y') if params['activity']['start_at'].present?
    params['activity']['end_at'] = Date.strptime(params['activity']['end_at'], '%d/%m/%Y') if params['activity']['end_at'].present?
  end

  def update_participants
    @activity.participants.clear && return if params['activity']['participants'].nil?

    profile_ids = params['activity']['participants']['profile_ids'].map { |id| id.to_i }

    current_profile_ids = @activity.participants.pluck(:profile_id)

    removed_profile_ids = current_profile_ids - profile_ids
    @activity.participants.where(profile_id: removed_profile_ids).delete_all

    profile_ids = profile_ids - current_profile_ids
    profile_ids.map { |profile_id| @activity.participants.create(profile_id: profile_id) }
  end
end
