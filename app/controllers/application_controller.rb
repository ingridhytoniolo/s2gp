class ApplicationController < ActionController::Base
  around_action :switch_locale
  before_action :load_group_info

  private

  def switch_locale(&action)
    cookies[:locale] = params[:locale] if params[:locale]

    locale = cookies[:locale] || 'pt-BR'
    I18n.with_locale(locale, &action)
  end

  def load_group_info
    @group = {
      name: 'GEPTA'
    }
  end
end
