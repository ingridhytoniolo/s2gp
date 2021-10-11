class ApplicationController < ActionController::Base
  around_action :switch_locale
  before_action :load_group_info

  private

  def switch_locale(&action)
    cookies[:locale] = params[:locale] if params[:locale]

    locale = cookies[:locale] || 'pt-BR'
    I18n.locale = locale
    I18n.with_locale(locale, &action)
  end

  def load_group_info
    @group = {
      name: 'GEPTA',
      long_name: 'Grupo de Estudos e Pesquisas em Tecnologia Aplicada',
      logo_url: 'gepta-logo.jpg',
      about: '
        <p>O GEPTA é um grupo de pesquisa, liderado pelos Professores doutores Luiz Antônio Pereira Neves e José Elmar Feger, situado no Setor de Educação Profissional e Tecnológica, da UFPR, no campus Politécnico de Curitiba.</p>
        <p>Este grupo desenvolve pesquisa acadêmica e aplicada na grande área Interdisciplinar na Universidade Federal do Paraná, tendo como foco principal promover pesquisas aplicadas nas linhas de processamento digital de imagens, engenharia biomédica e de reabilitação, biometria, sistemas embarcados, robótica, desenvolvimento de aplicações na WEB, tecnologias com dispositivos móveis e tecnologias para gestão da informação, aplicados na educação, na saúde e no turismo.<p>
      '
    }
  end
end
