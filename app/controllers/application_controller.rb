class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :load_group_info
  around_action :switch_locale

  private

  def user_not_authorized
    flash[:alert] = t('helpers.failure.unauthorized')
    redirect_to(request.referrer || app_path)
  end

  def switch_locale(&action)
    cookies[:locale] = params[:locale] if params[:locale]

    locale = cookies[:locale] || @group[:default_locale] || 'pt-BR'
    I18n.locale = locale
    I18n.with_locale(locale, &action)
  end

  def load_group_info
    @group = {}
    Setting.all.each.map {|c| @group[c.name.to_sym] = c.value}

    @group[:available_locales] = JSON.parse(@group[:available_locales])
  end
end
