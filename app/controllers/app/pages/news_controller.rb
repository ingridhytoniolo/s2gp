class App::Pages::NewsController < ApplicationController
  require 'mini_magick'
  require 'image_processing/mini_magick'

  before_action :authenticate_user!
  before_action :set_active_menu
  before_action :set_news, only: [:destroy, :edit, :show, :update]
  before_action :authorize_news

  layout 'app'

  def index
    @submenu = params[:show]

    if @submenu == 'all'
      @news = News.all.order(created_at: :desc)
    elsif @submenu == 'mine'
      @news = current_user.profile.news.order(created_at: :desc)
    else
      @news = News.active.order(created_at: :desc)
    end
  end

  def show; end

  def new
    @news = News.new
  
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @news = News.new(news_params)
    @news.profile = current_user.profile

    resize_cover

    if @news.save
      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  def destroy
    if @news.destroy
      flash[:notice] = t('shared.success')
      redirect_to app_news_index_path
    else
      flash[:alert] = t('shared.error')
      redirect_to request.referer
    end
  end
  
  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    resize_cover

    if @news.update(news_params.except(:remove_cover))
      remove_cover if news_params[:remove_cover] == 'true'

      flash[:notice] = t('shared.success')
      redirect_to request.referer
    else
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  private

  def authorize_news
    if @news.nil?
      authorize :news
    else
      authorize @news
    end
  end

  def remove_cover
    @news.cover.delete
  end

  def resize_cover
    return unless news_params['cover']

    acceptable_types = ['image/jpeg', 'image/png']
    return unless acceptable_types.include?(news_params['cover'].content_type)

    temp_path = news_params['cover'].tempfile.path

    image = MiniMagick::Image.open(temp_path)
    image.resize '640x640'
    image.write temp_path
  end

  def set_active_menu
    @active_menu = 'news'
  end

  def set_news
    @news = News.find(params[:id])
  rescue
    flash[:alert] = t('shared.error')
    redirect_to app_news_index_path
  end

  def news_params
    params.require(:news).permit(:cover, :description, :end_at, :remove_cover, :start_at, :title)
  end
end
