class App::Pages::EventsController < ApplicationController
  require 'mini_magick'
  require 'image_processing/mini_magick'

  before_action :authenticate_user!
  before_action :set_active_menu
  before_action :set_event, only: [:destroy, :edit, :show, :update]
  before_action :authorize_event

  layout 'app'

  def index
    @submenu = params[:show]

    if @submenu == 'all'
      @events = Event.all.order(date: :desc)
    elsif @submenu == 'mine'
      @events = current_user.profile.events.order(created_at: :desc)
    else
      @events = Event.active.order(date: :desc)
    end
  end

  def show; end

  def new
    @event = Event.new
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @event = Event.new(event_params)
    @event.profile = current_user.profile

    if @event.save
      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = t('shared.success')
      redirect_to app_events_path
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
    if @event.update(event_params)
      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_event
    if @event.nil?
      authorize :event
    else
      authorize @event
    end
  end

  def event_params
    params.require(:event).permit(:date, :description, :location, :title)
  end

  def set_active_menu
    @active_menu = 'events'
  end

  def set_event
    @event = Event.find(params[:id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_events_path
  end
end
