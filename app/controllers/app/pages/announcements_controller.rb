class App::Pages::AnnouncementsController < ApplicationController
  # require 'mini_magick'
  # require 'image_processing/mini_magick'

  before_action :authenticate_user!
  before_action :set_active_menu
  before_action :set_announcement, only: [:destroy, :edit, :show, :update]
  before_action :authorize_announcement

  layout 'app'

  def index
    @submenu = params[:show]

    if @submenu == 'all'
      @announcements = Announcement.all.order(created_at: :desc)
    elsif @submenu == 'mine'
      @announcements = current_user.profile.announcements.order(created_at: :desc)
    else
      @announcements = Announcement.active.order(created_at: :desc)
    end
  end

  def show; end

  def new
    @announcement = Announcement.new
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @announcement = Announcement.new(announcement_params)
    @announcement.profile = current_user.profile

    if @announcement.save
      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def destroy
    if @announcement.destroy
      flash[:notice] = t('shared.success')
      redirect_to app_announcements_path
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
    if @announcement.update(announcement_params) #.except(:remove_cover))
      # remove_cover if announcement_params[:remove_cover] == 'true'

      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_announcement
    if @announcement.nil?
      authorize :announcement
    else
      authorize @announcement
    end
  end

  # def remove_cover
  #   @announcement.cover.delete
  # end

  def set_active_menu
    @active_menu = 'announcement'
  end

  def set_announcement
    @announcement = Announcement.find(params[:id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_announcements_path
  end

  def announcement_params
    params.require(:announcement).permit(:description, :end_at, :external_url, :start_at, :title)
  end
end
