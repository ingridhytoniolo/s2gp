class App::Pages::ProfileController < ApplicationController
  # before_action :authenticate_user!
  # before_action :authorize_profile
  before_action :set_active_menu

  layout 'app'

  def index
    @profile = current_user.profile
  end
  
  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    if current_user.profile.update(user_params)
      flash[:notice] = "{success}"
      redirect_to app_profile_index_path
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_profile
    authorize :profile
  end

  def set_active_menu
    @active_menu = 'profile'
  end

  def user_params
    params.require(:profile).permit(:avatar, :name, :role, lattes_url: [])
  end
end
