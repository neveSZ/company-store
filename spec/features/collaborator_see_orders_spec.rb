require 'rails_helper'

feature 'Collaborator see all orders' do
  scenario 'buyer history' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    collaborator2 = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator1 = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product1 = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator2)
    product2 = Product.create!(name: 'S30', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator2)
    product3 = Product.create!(name: 'S40', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator1)
    order1 = Order.create!(collaborator: collaborator1, product: product1)
    order2 = Order.create!(collaborator: collaborator1, product: product2)
    order2.set_canceled
    Order.create!(collaborator: collaborator2, product: product3)

    login_as collaborator1
    visit root_path
    click_on 'Minhas compras'

    expect(page).to have_content('S20')
    expect(page).to have_content('S30')
    expect(page).to_not have_content('S40')
    expect(page).to have_content('negotiation')
    expect(page).to have_content('canceled')
  end

  scenario 'seller history' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    collaborator2 = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator1 = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product1 = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator2)
    product2 = Product.create!(name: 'S30', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator2)
    product3 = Product.create!(name: 'S50', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator1)
    order1 = Order.create!(collaborator: collaborator1, product: product1)
    order2 = Order.create!(collaborator: collaborator1, product: product2)
    order2.set_completed
    order3 = Order.create!(collaborator: collaborator2, product: product3)

    login_as collaborator2
    visit root_path
    click_on 'Minhas vendas'

    expect(page).to have_content('S20')
    expect(page).to have_content('S30')
    expect(page).to_not have_content('S50')
    expect(page).to have_content('negotiation')
    expect(page).to have_content('completed')
  end

  scenario 'no orders' do
    category = Category.create!(name: 'Celulares', description: 'teste')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product1 = Product.create!(name: 'S20', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator)
    product2 = Product.create!(name: 'S30', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator)
    product3 = Product.create!(name: 'S50', category: category, description: 'teste teste', value: 10.00, collaborator: collaborator)

    login_as collaborator
    visit root_path
    click_on 'Minhas vendas'

    expect(page).to have_content('Você ainda não realizou vendas')
  end
end
