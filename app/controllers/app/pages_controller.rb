class App::PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_page
  before_action :set_active_menu

  layout 'app'

  def index; end

  private

  def authorize_page
    authorize :page
  end

  def set_active_menu
    @active_menu = 'dashboard'
  end
end
