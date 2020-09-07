require 'rails_helper'

feature 'Collaborator see product info' do
  scenario 'sucessfully from home page' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    Product.create!(name: 'SAM20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator)
    Product.create!(name: 'SAM30', category: category, description: 'teste produto2', value: 100.00, status: 0, collaborator: collaborator)

    login_as collaborator
    visit root_path
    click_on 'SAM20'

    expect(page).to have_content('SAM20')
    expect(page).to have_content('Vendido por: Victor Neves Silva - Tecnologia')
    expect(page).to have_content('Categoria: Celulares')
    expect(page).to have_content('teste produto')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Comprar')
    expect(page).to_not have_content('SAM30')
  end

  scenario 'directly page' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'SAM20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator)

    login_as collaborator
    visit "/products/#{product.id}"

    expect(page).to have_content('SAM20')
    expect(page).to have_content('Vendido por: Victor Neves Silva - Tecnologia')
    expect(page).to have_content('Categoria: Celulares')
    expect(page).to have_content('teste produto')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Comprar')
  end

  scenario 'from other company' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator_other = Collaborator.create!(email: 'victor@teste.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'SAM20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator_other)

    login_as collaborator
    visit "/products/#{product.id}"

    expect(page).to have_content('Produto indisponível')
    expect(page).to_not have_content('SAM20')
  end
end
