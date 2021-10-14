class App::Pages::SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_settings
  before_action :set_active_menu

  layout 'app'

  def index; end

  private

  def authorize_settings
    authorize :settings
  end

  def set_active_menu
    @active_menu = 'settings'
  end
end
