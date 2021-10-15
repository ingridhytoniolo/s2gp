class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :switch_locale
  before_action :load_group_info

  private

  def user_not_authorized
    flash[:alert] = t('helpers.failure.unauthorized')
    redirect_to(request.referrer || app_path)
  end

  def switch_locale(&action)
    cookies[:locale] = params[:locale] if params[:locale]

    locale = cookies[:locale] || 'pt-BR'
    I18n.locale = locale
    I18n.with_locale(locale, &action)
  end

  def load_group_info
    @group = {
      name: 'GEPTA',
      logo_url: 'gepta-logo.jpg',
      long_name_en: 'Applied Technology Study and Research Group',
      about_en: '
        <p>GEPTA is a research group, led by Professors Doctors Luiz Antônio Pereira Neves and José Elmar Feger, located in the Professional and Technological Education Sector of UFPR, on the Polytechnic campus of Curitiba.</p>
        <p>This group develops academic and applied research in the large Interdisciplinary area at the Federal University of Paraná, with the main focus of promoting applied research in the lines of digital image processing, biomedical and rehabilitation engineering, biometrics, embedded systems, robotics, web application development , technologies with mobile devices and technologies for information management, applied in education, health and tourism.<p>
      ',
      long_name_es: 'Grupo de Estudio e Investigación de Tecnología Aplicada',
      about_es: '
        <p> GEPTA es un grupo de investigación, liderado por los Profesores Doctores Luiz Antônio Pereira Neves y José Elmar Feger, ubicado en el Sector de Educación Profesional y Tecnológica de la UFPR, en el campus Politécnico de Curitiba. </p>
        <p> Este grupo desarrolla investigación académica y aplicada en la gran área Interdisciplinaria de la Universidad Federal de Paraná, con el foco principal de promover la investigación aplicada en las líneas de procesamiento de imágenes digitales, ingeniería biomédica y rehabilitación, biometría, sistemas embebidos, robótica, desarrollo de aplicaciones web, tecnologías con dispositivos móviles y tecnologías para la gestión de la información, aplicadas en educación, salud y turismo. <p>
      ',
      long_name_fr: 'Groupe d’études et de Recherche en Technologie Appliquée,',
      about_fr: '
        <p>GEPTA est un groupe de recherche dirigé par les professeurs Luiz Antônio Pereira Neves et José Elmar Feger, du secteur de l’enseignement professionnel et technologique, de l’université fédérale de Paraná( UFPR), situé au campus polytechnique de Curitiba.</p>
        <p>Ce groupe développe des activités de recherche universitaire  appliquée dans les principaux domaines interdisciplinaires de l’Université fédérale de Paraná, principalement dans le but de promouvoir la recherche appliquée dans les domaines du traitement des images numériques, de l’ingénierie biomédicale , de la réhabilitation, de la biométrie, des systèmes embarqués, de la robotique, développement des applications Web. , technologies avec dispositifs mobiles et technologies de gestion de l’information, appliquées dans les domaines de l’éducation, de la santé et du tourisme.<p>
      ',
      long_name_pt_BR: 'Grupo de Estudos e Pesquisas em Tecnologia Aplicada',
      about_pt_BR: '
        <p>O GEPTA é um grupo de pesquisa, liderado pelos Professores doutores Luiz Antônio Pereira Neves e José Elmar Feger, situado no Setor de Educação Profissional e Tecnológica, da UFPR, no campus Politécnico de Curitiba.</p>
        <p>Este grupo desenvolve pesquisa acadêmica e aplicada na grande área Interdisciplinar na Universidade Federal do Paraná, tendo como foco principal promover pesquisas aplicadas nas linhas de processamento digital de imagens, engenharia biomédica e de reabilitação, biometria, sistemas embarcados, robótica, desenvolvimento de aplicações na WEB, tecnologias com dispositivos móveis e tecnologias para gestão da informação, aplicados na educação, na saúde e no turismo.<p>
      '
    }
  end
end
