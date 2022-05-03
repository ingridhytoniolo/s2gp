class App::Pages::SettingsController < ApplicationController
  include Rails.application.routes.url_helpers

  before_action :authenticate_user!
  before_action :authorize_settings
  before_action :set_active_menu
  before_action :set_setting, only: [:delete_image, :edit, :update]

  layout 'app'

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end
  
  def index; end

  def delete_image
    if @setting.image.attached?
      @setting.image.purge

      cover_image_url if @setting.name == 'cover_image'

      flash[:notice] = t('shared.success')
    end

    redirect_to request.referer
  end

  def update
    resize_image
  
    if @setting.update(setting_params)
      cover_image_url

      flash[:notice] = t('shared.success')
      redirect_to app_settings_path
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_settings
    authorize :settings
  end

  def cover_image_url
    cover_image = Setting.find_by(name: 'cover_image')
    
    if @setting.image.attached?
      cover_image.update(value: rails_blob_path(@setting.image , only_path: true))
    else
      cover_image.update(value: nil)
    end
  end

  def resize_image
    return unless setting_params['image']

    acceptable_types = ['image/jpeg', 'image/png']
    return unless acceptable_types.include?(setting_params['image'].content_type)

    temp_path = setting_params['image'].tempfile.path

    image = MiniMagick::Image.open(temp_path)
    image.resize '420x420'
    image.write temp_path
  end

  def set_active_menu
    @active_menu = 'settings'
  end

  def set_setting
    @setting = Setting.find_by(name: params[:id] || params[:setting_id]) || Setting.find_by(id: params[:id])

    raise unless @setting
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_settings_path
  end

  def setting_params
    params.require(:setting).permit(:image, :value, value: [])
  end
end
