class App::Pages::ProfileController < ApplicationController
  require 'mini_magick'
  require 'image_processing/mini_magick'

  before_action :authenticate_user!
  before_action :authorize_profile
  before_action :set_active_menu
  before_action :set_profile

  layout 'app'

  def index; end
  
  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    helpers.resize_avatar(profile_params['avatar'])

    if @profile.update(profile_params)
      flash[:notice] = t('shared.success')

      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def new_avatar
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def delete_avatar
    if @profile.avatar.attached?
      @profile.avatar.purge
      flash[:notice] = t('shared.success')
    end

    redirect_to request.referer
  end

  private

  def authorize_profile
    authorize :profile
  end

  def profile_params
    if current_user.admin?
      params.require(:profile).permit(:id, :avatar, :name, :role, :lattes_url)
    else
      params.require(:profile).permit(:avatar, :name, :role, :lattes_url)
    end
  end

  def set_active_menu
    @active_menu = 'profile'
  end

  def set_profile
    @profile = admin? ? Profile.find(params[:id] || params[:profile_id]) : current_user.profile
  end

  def admin?
    current_user.admin? && (params[:id] || params[:profile_id])
  end
end
