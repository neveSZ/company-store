require 'rails_helper'

feature 'Collaborator buy a product' do
  scenario 'from home' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: seller)

    login_as collaborator
    visit root_path
    click_on 'Comprar'

    expect(page).to have_content('Pedido realizado com sucesso')
    expect(page).to have_content('Pedido #1 - S20')
    expect(page).to have_content('teste teste')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('teste teste')
  end

  scenario 'has no more visible' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: seller)

    login_as collaborator
    visit root_path
    click_on 'Comprar'
    visit root_path

    expect(page).to_not have_content('S20')
  end

  scenario 'from product page ' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: seller)

    login_as collaborator
    visit "/products/#{product.id}"
    click_on 'Comprar'
    visit root_path

    expect(page).to_not have_content('S20')
  end

  scenario 'from same people in product' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: seller)

    login_as seller
    visit "/products/#{product.id}"

    expect(page).to_not have_content('Comprar')
  end

  scenario 'from same people in home page' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: seller)

    login_as seller
    visit root_path

    expect(page).to_not have_content('Comprar')
  end
end
