class PagesController < ApplicationController
  def contact; end
  
  def index; end

  def team
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
  end
end
