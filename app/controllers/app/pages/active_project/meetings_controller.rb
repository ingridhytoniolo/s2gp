class App::Pages::ActiveProject::MeetingsController < App::Pages::ActiveProjectController
  layout 'app'

  def index
    @meetings = @project.meetings.order(date: :asc)
  end
end
