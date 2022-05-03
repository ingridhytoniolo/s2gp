class App::Pages::SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_settings
  before_action :set_active_menu
  before_action :set_setting, only: [:edit, :update]

  layout 'app'

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end
  
  def index; end

  def update
    if @setting.update(setting_params)
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

  def set_active_menu
    @active_menu = 'settings'
  end

  def set_setting
    @setting = Setting.find_by(name: params[:id]) || Setting.find_by(id: params[:id])

    raise unless @setting
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_settings_path
  end

  def setting_params
    params.require(:setting).permit(:value, value: [])
  end
end
