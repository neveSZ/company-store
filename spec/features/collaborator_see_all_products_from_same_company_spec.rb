require 'rails_helper'

feature 'collaborator can see all products from his company' do
  scenario 'successfully' do
    category = Category.create!(name: 'Celulares', description: 'ASDIKPOSDKOPKOPADKOPASD')

    collaborator_main = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator_secundary = Collaborator.create!(email: 'victor@empresa.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    images = ['spec/files/images/1.jpg', 'spec/files/images/2.jpg', 'spec/files/images/3.jpg']
    Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: collaborator_main)
    Product.create!(name: 'S30', category: category, description: 'teste teste', value: 100.00, status: 0, collaborator: collaborator_main)
    Product.create!(name: 'S40', category: category, description: 'teste teste', value: 200.00, status: 1, collaborator: collaborator_main)
    Product.create!(name: 'S50', category: category, description: 'teste teste', value: 300.00, status: 2, collaborator: collaborator_main)
    Product.create!(name: 'S60', category: category, description: 'teste teste', value: 400.00, status: 3, collaborator: collaborator_main)
    Product.create!(name: 'S70', category: category, description: 'teste teste', value: 400.00, status: 0, collaborator: collaborator_secundary)

    login_as collaborator_main
    visit root_path
    expect(page).to have_content('S20')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('S30')
    expect(page).to have_content('R$ 100,00')
    expect(page).to_not have_content('S40')
    expect(page).to_not have_content('S50')
    expect(page).to_not have_content('S60')
    expect(page).to_not have_content('S70')
    expect(page).to have_content('Comprar', count: 2)
  end

  
end
