require 'rails_helper'

feature 'Seller change product status' do
  scenario 'sucessfully to inactive' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)

    login_as seller
    visit root_path
    click_on 'Meus produtos'
    click_on 'S20'
    click_on 'Suspender venda'

    expect(page).to have_content('S20')
    expect(page).to have_content('inactive')
  end

  scenario 'sucessfully to avaliable' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    product.set_inactive

    login_as seller
    visit root_path
    click_on 'Meus produtos'
    click_on 'S20'
    click_on 'Reativar venda'

    expect(page).to have_content('S20')
    expect(page).to have_content('avaliable')
  end

  scenario 'to inactive and product dont show' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)

    login_as seller
    visit root_path
    click_on 'Meus produtos'
    click_on 'S20'
    click_on 'Suspender venda'
    visit root_path

    expect(page).to_not have_content('S20')
  end

  scenario 'to avaliable and product show again' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    product.set_inactive

    login_as seller
    visit root_path
    click_on 'Meus produtos'
    click_on 'S20'
    click_on 'Reativar venda'
    visit root_path

    expect(page).to have_content('S20')
  end

  scenario 'hide buttons in negotiation' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    buyer = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    order = Order.create!(collaborator: buyer, product: product)

    login_as seller
    visit root_path
    click_on 'Meus produtos'
    click_on 'S20'

    expect(page).to_not have_content('Reativar venda')
    expect(page).to_not have_content('Suspender venda')
    expect(page).to have_content('negotiation')
  end

  scenario 'hide buttons in sold' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    buyer = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    order = Order.create!(collaborator: buyer, product: product)
    order.set_completed

    login_as seller
    visit root_path
    click_on 'Meus produtos'
    click_on 'S20'

    expect(page).to_not have_content('Reativar venda')
    expect(page).to_not have_content('Suspender venda')
    expect(page).to have_content('sold')
  end
end
