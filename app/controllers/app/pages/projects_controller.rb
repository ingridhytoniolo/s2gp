class App::Pages::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_project
  before_action :set_active_menu

  layout 'app'

  def index; end

  private

  def authorize_project
    authorize :project
  end

  def set_active_menu
    @active_menu = 'projects'
  end
end
