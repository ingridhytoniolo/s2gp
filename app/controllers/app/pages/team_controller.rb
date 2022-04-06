class App::Pages::TeamController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_team
  before_action :set_active_menu

  layout 'app'

  def index; end

  private

  def authorize_team
    authorize :team
  end

  def set_active_menu
    @active_menu = 'team'
  end
end
