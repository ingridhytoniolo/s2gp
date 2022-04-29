class App::PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_page
  before_action :set_active_menu

  layout 'app'

  def index
    @news = News.active.last(3) # fix
    @meetings = Meeting.active.last(3) # fix
    @events = Event.active.last(3) # fix
    @announcements = Announcement.active.last(3) # fix
  end

  private

  def authorize_page
    authorize :page
  end

  def set_active_menu
    @active_menu = 'dashboard'
  end
end
