class App::PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_page
  before_action :set_active_menu

  layout 'app'

  def index
    @news = News.active.last(3)
    @meetings = user_meetings.last(3)
    @events = Event.active.last(3)
    @announcements = Announcement.active.last(3)
  end

  private

  def authorize_page
    authorize :page
  end

  def set_active_menu
    @active_menu = 'dashboard'
  end

  def user_meetings
    return Meeting.all if current_user.admin?

    project_ids = current_user.profile.projects.ids

    Meeting.where(public: true).
      or(Meeting.where(project_id: project_ids)).
      or(current_user.profile.meetings)
  end
end
