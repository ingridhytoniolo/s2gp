class App::Pages::MeetingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_menu
  before_action :set_meeting, only: [:destroy, :edit, :show, :update]
  before_action :authorize_meeting

  layout 'app'

  def index
    @submenu = params[:show]

    if @submenu == 'all'
      @meetings = Meeting.all.order(date: :asc)
    elsif @submenu == 'mine'
      @meetings = current_user.profile.meetings.order(date: :asc)
    else
      @meetings = Meeting.active.order(date: :asc)
    end
  end

  def show; end

  def new
    @meeting = Meeting.new
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.profile = current_user.profile

    if @meeting.save
      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def destroy
    if @meeting.destroy
      flash[:notice] = t('shared.success')
      redirect_to app_meetings_path
    else
      flash[:alert] = t('shared.error')
      redirect_to request.referer
    end
  end
  
  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    if @meeting.update(meeting_params)
      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_meeting
    if @meeting.nil?
      authorize :meeting
    else
      authorize @meeting
    end
  end

  def meeting_params
    params.require(:meeting).permit(:date, :description, :location, :project_id, :public, :streaming_url, :title)
  end

  def set_active_menu
    @active_menu = 'meetings'
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_meetings_path
  end
end
