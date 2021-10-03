class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&action)
    cookies[:locale] = params[:locale] if params[:locale]

    locale = cookies[:locale] || 'pt-BR'
    I18n.with_locale(locale, &action)
  end
end
