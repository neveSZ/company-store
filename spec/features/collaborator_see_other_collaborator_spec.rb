require 'rails_helper'

feature 'collaborator see other collaborator details' do
  scenario 'from product page' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product1 = Product.create!(name: 'S20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator)
    product2 = Product.create!(name: 'S30', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator)
    product3 = Product.create!(name: 'S40', category: category, description: 'teste produto', value: 10.00, status: 1, collaborator: collaborator)

    login_as collaborator
    visit root_path
    click_on 'S20'
    click_on 'Vendido por: Victor Neves Silva - Tecnologia'

    expect(page).to have_content(collaborator.name)
    expect(page).to have_content(collaborator.email)
    expect(page).to have_content(collaborator.birth_date)
    expect(page).to have_content(collaborator.role)
    expect(page).to have_content(collaborator.department)
    expect(page).to have_content(product1.name)
    expect(page).to have_content(product2.name)
    expect(page).to_not have_content(product3.name)
  end

  scenario 'directly' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    collaborator1 = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator2 = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    product1 = Product.create!(name: 'S20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator1)
    product2 = Product.create!(name: 'S30', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: collaborator1)
    product3 = Product.create!(name: 'S40', category: category, description: 'teste produto', value: 10.00, status: 1, collaborator: collaborator1)

    login_as collaborator2
    visit "/collaborators/#{collaborator1.id}"

    expect(page).to have_content(collaborator1.name)
    expect(page).to have_content(collaborator1.email)
    expect(page).to have_content(collaborator1.birth_date)
    expect(page).to have_content(collaborator1.role)
    expect(page).to have_content(collaborator1.department)
    expect(page).to have_content(product1.name)
    expect(page).to have_content(product2.name)
    expect(page).to_not have_content(product3.name)
  end

  scenario 'from other company' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator_other = Collaborator.create!(email: 'victor@teste.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')

    login_as collaborator
    visit "/collaborators/#{collaborator_other.id}"

    expect(page).to_not have_content(collaborator.name)
    expect(page).to have_content 'Esse colaborador não é da sua empresa'
  end
end
