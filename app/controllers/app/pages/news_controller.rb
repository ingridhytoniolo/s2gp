class App::Pages::NewsController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize_news
  # before_action :set_active_menu
  # before_action :set_news, only: [:show, :edit, :update]

  layout 'app'

  def index
    @news = [] #Resource.all.order(:name)
  end

  # def show
  #   respond_to do |format|
  #     format.js { render layout: false }
  #   end
  # end

  # def new
  #   @resource = Resource.new
  
  #   respond_to do |format|
  #     format.js { render layout: false }
  #   end
  # end

  # def create
  #   @resource = Resource.new(resource_params)

  #   if @resource.save
  #     flash[:notice] = t('shared.success')
  #     redirect_to app_resources_path
  #   else
  #     respond_to do |format|
  #       format.js { render layout: false }
  #     end
  #   end
  # end
  
  # def edit
  #   respond_to do |format|
  #     format.js { render layout: false }
  #   end
  # end

  # def update
  #   if @resource.update(resource_params)
  #     flash[:notice] = t('shared.success')
  #     redirect_to app_resources_path
  #   else
  #     respond_to do |format|
  #       format.js { render layout: false }
  #     end
  #   end
  # end

  private

  # def authorize_resource
  #   authorize :resource
  # end

  # def set_active_menu
  #   @active_menu = 'resources'
  # end

  # def set_resource
  #   @resource = Resource.find(params[:id])
  # rescue
  #   flash[:alert] = t('shared.error')
  #   redirect_to app_resources_path
  # end

  # def resource_params
  #   params.require(:resource).permit(:code, :description, :end_at, :kind, :name, :start_at)
  # end
end
