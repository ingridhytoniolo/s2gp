class App::Pages::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_active_menu

  layout 'app'

  def index
    @users = User.all
  end

  private

  def set_active_menu
    @active_menu = 'users'
  end
end
