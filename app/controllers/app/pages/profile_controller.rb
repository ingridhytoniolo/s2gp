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
    resize_avatar

    if @profile.update(user_params)
      flash[:notice] = "{success}"
      redirect_to app_profile_index_path
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
      flash[:notice] = "{success}"
    end

    redirect_to app_profile_index_path
  end

  private

  def authorize_profile
    authorize :profile
  end

  def resize_avatar
    return unless user_params['avatar']

    acceptable_types = ['image/jpeg', 'image/png']
    return unless acceptable_types.include?(user_params['avatar'].content_type)

    temp_path = user_params['avatar'].tempfile.path

    image = MiniMagick::Image.open(temp_path)
    if image.height < image.width
      diff = (image.width - image.height) / 2
      image.crop "#{image.height}x#{image.height}+#{diff}+0"
    else
      diff = (image.height - image.width) / 2
      image.crop "#{image.width}x#{image.width}+0+#{diff}"
    end
    image.resize '240x240'
    image.write temp_path
  end

  def set_active_menu
    @active_menu = 'profile'
  end

  def set_profile
    @profile = current_user.profile
  end

  def user_params
    params.require(:profile).permit(:avatar, :name, :role, :lattes_url)
  end
end
