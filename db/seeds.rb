# Add demo group info
basic_data = [
  ['available_locales', ['pt-BR']],
  ['default_locale', 'pt-BR'],
  ['short_name', 'S2GP'],
  ['name_en', nil],
  ['about_en', nil],
  ['name_es', nil],
  ['about_es', nil],
  ['name_fr', nil],
  ['about_fr', nil],
  ['name_pt_BR', 'Sistema Gerenciador de Grupo de Pesquisa'],
  ['about_pt_BR', 'Este sistema vislumbra alcançar as necessidades administrativas de um Grupo de Pesquisa no atual mundo digital, conectando informações e pessoas, com maior facilidade e controle da liderança.'],
  ['cover_image', nil],
  ['facebook_url', nil],
  ['instagram_url', nil],
  ['twitter_url', nil],
  ['address', nil],
  ['contact_information', nil],
  ['google_maps_api_key', nil]
]

basic_data.each do |data|
  Setting.create!(name: data[0], value: data[1])
end

# Create admin user
User.create!(email: 'admin@s2gp.br', password: 's2gp@123', roles: ['admin']).confirm
