class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&action)
    session[:locale] = params[:locale] if params[:locale]

    locale = session[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
