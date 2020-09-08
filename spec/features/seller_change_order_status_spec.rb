require 'rails_helper'

feature 'Seller change order status' do
  scenario 'sucessfully completed' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    buyer = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    order = Order.create!(collaborator: buyer, product: product)

    login_as seller
    visit root_path
    click_on 'Minhas vendas'
    click_on "Pedido ##{order.id} - #{product.name}"
    click_on 'Concluir venda'
    fill_in 'Valor final', with: 20.00
    click_on 'Finalizar'

    expect(page).to have_content('S20')
    expect(page).to have_content('completed')
  end

  scenario 'sucessfully canceled' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    buyer = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    order = Order.create!(collaborator: buyer, product: product)

    login_as seller
    visit root_path
    click_on 'Minhas vendas'
    click_on "Pedido ##{order.id} - #{product.name}"
    click_on 'Cancelar venda'

    expect(page).to have_content('S20')
    expect(page).to have_content('canceled')
  end

  scenario 'to completed and product dont show' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    buyer = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    order = Order.create!(collaborator: buyer, product: product)

    login_as seller
    visit root_path
    click_on 'Minhas vendas'
    click_on "Pedido ##{order.id} - #{product.name}"
    click_on 'Concluir venda'
    fill_in 'Valor final', with: 20.00
    click_on 'Finalizar'
    visit root_path

    expect(page).to_not have_content('S20')
    expect(page).to have_content('Nenhum produto disponível')
  end

  scenario 'to canceled and product show again' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    buyer = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: seller)
    order = Order.create!(collaborator: buyer, product: product)

    login_as seller
    visit root_path
    click_on 'Minhas vendas'
    click_on "Pedido ##{order.id} - #{product.name}"
    click_on 'Cancelar venda'
    visit root_path

    expect(page).to have_content('S20')
  end
end
