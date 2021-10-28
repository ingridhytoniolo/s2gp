class App::Pages::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :set_active_menu

  layout 'app'

  def index
    @users = User.all.order(:email)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "{success}"
      redirect_to app_users_path
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    @user = User.find(params[:id])

    @user.update(roles: nil) if user_params[:roles].nil?

    if @user.update_without_password(user_params)
      flash[:notice] = "{success}"
      redirect_to app_users_path
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_user
    authorize :user
  end

  def set_active_menu
    @active_menu = 'users'
  end

  def user_params
    params.require(:user).permit(:email, :password, roles: [])
  end
end
