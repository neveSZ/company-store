require 'rails_helper'

feature 'Collaborator search for a product' do
  scenario 'exact match' do
    category = Category.create!(name: 'SAM20', description: 'ASDIKPOSDKOPKOPADKOPASD')
    other_category = Category.create!(name: 'XPTO', description: 'ASDIKPOSDKOPKOPADKOPASD')
    collaborator_main = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator_secundary = Collaborator.create!(email: 'victor@empresa.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    Product.create!(name: 'SAM20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: collaborator_main) # Nome
    Product.create!(name: 'SAM30', category: other_category, description: 'teste teste', value: 100.00, status: 0, collaborator: collaborator_main) # NAO TEM NADA
    Product.create!(name: 'SAM40', category: category, description: 'teste teste', value: 400.00, status: 0, collaborator: collaborator_main) # Categoria
    Product.create!(name: 'SAM50', category: category, description: 'teste teste', value: 400.00, status: 0, collaborator: collaborator_secundary) # NAO OUTRA EMPRESA
    Product.create!(name: 'SAM60', category: category, description: 'SAM20', value: 400.00, status: 0, collaborator: collaborator_main) # Descricao
    Product.create!(name: 'SAM70', category: category, description: 'teste teste', value: 400.00, status: 1, collaborator: collaborator_secundary) # NAO STATUS != 0

    login_as collaborator_main
    visit root_path
    fill_in 'product_search', with: 'SAM20'
    click_on 'Pesquisar'

    expect(page).to have_content('SAM20', count: 2)
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('SAM40')
    expect(page).to have_content('SAM60')
    expect(page).to_not have_content('SAM30')
    expect(page).to_not have_content('SAM50')
    expect(page).to_not have_content('SAM70')
    expect(page).to have_content('Comprar', count: 3)
  end

  scenario 'partial match' do
    category = Category.create!(name: 'SAM20', description: 'ASDIKPOSDKOPKOPADKOPASD')
    other_category = Category.create!(name: 'XPTO', description: 'ASDIKPOSDKOPKOPADKOPASD')
    collaborator_main = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator_secundary = Collaborator.create!(email: 'victor@empresa.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    Product.create!(name: 'SAM20', category: category, description: 'teste teste', value: 10.00, status: 0, collaborator: collaborator_main) # SIM
    Product.create!(name: 'SAM30', category: other_category, description: 'teste teste', value: 100.00, status: 0, collaborator: collaborator_main) # SIM
    Product.create!(name: 'SAM40', category: category, description: 'teste teste', value: 400.00, status: 0, collaborator: collaborator_main) # SIM
    Product.create!(name: 'SAM50', category: category, description: 'teste teste', value: 400.00, status: 0, collaborator: collaborator_secundary) # NAO
    Product.create!(name: 'SAM60', category: category, description: 'SAM20', value: 400.00, status: 0, collaborator: collaborator_main) # SIM
    Product.create!(name: 'SAM70', category: category, description: 'teste teste', value: 400.00, status: 1, collaborator: collaborator_secundary) # NAO
    Product.create!(name: 'SAM80', category: category, description: 'teste teste', value: 400.00, status: 1, collaborator: collaborator_main) # NAO

    login_as collaborator_main
    visit root_path
    fill_in 'product_search', with: 'SAM'
    click_on 'Pesquisar'

    expect(page).to have_content('SAM20', count: 2)
    expect(page).to have_content('SAM30')
    expect(page).to have_content('SAM40')
    expect(page).to_not have_content('SAM50')
    expect(page).to have_content('SAM60')
    expect(page).to_not have_content('SAM70')
    expect(page).to_not have_content('SAM80')
  end

  scenario 'find nothing' do
    category = Category.create!(name: 'SAM20', description: 'ASDIKPOSDKOPKOPADKOPASD')
    collaborator_main = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    Product.create!(name: 'SAM80', category: category, description: 'teste teste', value: 400.00, status: 1, collaborator: collaborator_main)

    login_as collaborator_main
    visit root_path
    fill_in 'product_search', with: 'SAM'
    click_on 'Pesquisar'

    expect(page).to have_content('Nenhum produto disponível')
  end
end
