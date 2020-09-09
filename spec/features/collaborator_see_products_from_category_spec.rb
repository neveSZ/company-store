require 'rails_helper'

feature 'collaborator see all products from category' do
  scenario 'successfully' do
    cellphone = Category.create!(name: 'Celulares', description: 'teste')
    car = Category.create!(name: 'Carros', description: 'teste')

    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')

    Product.create!(name: 'S20', category: cellphone, description: 'teste teste', value: 10.00, status: 0, collaborator: collaborator)
    Product.create!(name: 'S30', category: cellphone, description: 'teste teste', value: 100.00, status: 0, collaborator: collaborator)
    Product.create!(name: 'S40', category: cellphone, description: 'teste teste', value: 100.00, status: 1, collaborator: collaborator)
    Product.create!(name: 'Celta', category: car, description: 'teste teste', value: 200.00, status: 0, collaborator: collaborator)
    Product.create!(name: 'Palio', category: car, description: 'teste teste', value: 300.00, status: 0, collaborator: collaborator)

    login_as collaborator
    visit root_path
    click_on cellphone.name

    expect(page).to have_content('S20')
    expect(page).to have_content('S30')
    expect(page).to_not have_content('S40')
    expect(page).to_not have_content('Celta')
  end

  scenario 'no product from his company' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator_other = Collaborator.create!(email: 'victor@teste.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')

    Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: collaborator_other)
    Product.create!(name: 'S30', category: category, description: 'teste teste', value: 100.00, status: 0, collaborator: collaborator_other)
    Product.create!(name: 'S40', category: category, description: 'teste teste', value: 100.00, status: 1, collaborator: collaborator_other)

    login_as collaborator
    visit root_path
    click_on category.name

    expect(page).to_not have_content('S20')
    expect(page).to_not have_content('S30')
    expect(page).to_not have_content('S40')
  end

  scenario 'no categories' do
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')

    login_as collaborator
    visit root_path

    expect(page).to have_content('Nenhuma categoria disponível')
  end
end
