class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :switch_locale
  before_action :load_group_info
  before_action :load_fake_data

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

  def load_fake_data
    @team = [
      {
        photo_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/img-20161101-wa0064ab.jpg?122',
        name: 'Prof. Dr Alexander Robert Kutzke',
        role: 'Pesquisador',
        lattes_url: 'http://lattes.cnpq.br/3453803361614898'
      },{
        photo_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/4776893.jpg?114',
        name: 'Profa. MSc Andréia de Jesus',
        role: 'Pesquisador',
        lattes_url: 'http://lattes.cnpq.br/7018699031329280'
      },{
        photo_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/1869723.jpg?113',
        name: 'Prof. Dr José Elmar Feger',
        role: 'Pesquisador',
        lattes_url: 'http://lattes.cnpq.br/8671782571748625'
      },{
        photo_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/1702613.gif?118',
        name: 'Prof. Dr João Eugênio Marynowski',
        role: 'Pesquisador',
        lattes_url: 'http://lattes.cnpq.br/3265921900792672'
      },{
        photo_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/438422.jpg?113',
        name: 'Prof. Dr Luiz Antônio Pereira Neves',
        role: 'Pesquisador',
        lattes_url: 'http://lattes.cnpq.br/7888191553838017'
      },{
        photo_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/446012.jpg?118',
        name: 'Prof. Dr Reginaldo Daniel da Silveira',
        role: 'Pesquisador',
        lattes_url: 'http://lattes.cnpq.br/0369635613472038'
      }
    ]

    @projects = [
      {
        status: 'done',
        start_date: '2015-03',
        end_date: '2015-03',
        title: 'Biometria da Palma da Mão',
        main_goal: 'Desenvolver um sistema biométrico de reconhecimento de pessoas através da palma da mão no ambiente hardware e software, proporcionando uma alternativa viável de reconhecimento.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/8902252.png?250',
        members: 0
      },{
        status: 'done',
        start_date: '2015-03',
        end_date: '2016-06',
        title: 'Mão Robótica',
        main_goal: 'Desenvolver uma prótese robótica como uma opção viável para pacientes amputados de membros superiores, proporcionando melhor qualidade de vida.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/6607325.png?214',
        members: 0
        
      },{
        status: 'done',
        start_date: '2014-08',
        end_date: '2015-07',
        title: 'Qualidade em Educação',
        main_goal: 'Analisar a qualidade dos serviços prestados no setor, tomando-se como parâmetro a percepção de desempenho nas dimensões de qualidade de serviços por parte do aluno.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/8657979.gif?335',
        members: 0
      },{
        status: 'done',
        start_date: '2015-03',
        end_date: '2017-07',
        title: 'Projeto PIA ROBOT',
        main_goal: 'Desenvolver um robô para a interação homem-máquina aplicado as áreas da educação e da saúde.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/1892323.jpg?272',
        members: 0
      },{
        status: 'done',
        start_date: '2014-01',
        end_date: '2015-12',
        title: 'Regionalização do Turismo',
        main_goal: 'Analisar o legado do Programa de Regionalização de Turismo nas regiões turísticas localizadas no Estado do Paraná denominadas Corredor das Águas (Noroeste/PR) e Litoral do Paraná, no período compreendido entre os anos 2004 e 2014.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/8031601.jpg?339',
        members: 0
      },{
        status: 'done',
        start_date: '2017-03',
        end_date: '2018-12',
        title: 'SAFE',
        main_goal: 'Desenvolver um dispositivo de hardware e software, com interação através de um jogo de vídeo como uma opção viável de ferramenta de reabilitação para pacientes portadores de deficiências motoras dos membros superiores, proporcionando melhor qualidade de vida.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/1965725_orig.png',
        members: 0
      },{
        status: 'done',
        start_date: '2015-03',
        end_date: '2016-12',
        title: 'Smart Corridor',
        main_goal: 'Desenvolver um dispositivo inteligente para controlar o acesso de pessoas em um corredor, oferecendo uma alta acessibilidade através de orientações audiovisuais, proporcionando uma melhor interação de pessoas no meio ambiente.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/2110493.png?353',
        members: 0
      },{
        status: 'done',
        start_date: '0000-00',
        end_date: '0000-00',
        title: 'Projeto QRC Door',
        main_goal: 'Desenvolver um sistema inteligente de controle de acesso de uma porta, implementando recursos de Visão Computacional, utilizando WebCam e dispositivo móvel;  aplicando-o na área de segurança e gestão de informação.',
        image_url: 'https://gepta.weebly.com/uploads/2/1/3/6/21361068/sem-t-tulo.png?234',
        members: 0
      }
    ]
  end
end
