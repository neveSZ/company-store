require 'rails_helper'

feature 'Collaborators send and receive order messages' do
  scenario 'seller send message' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    buyer = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    seller = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: seller)

    login_as seller
    visit root_path
    click_on 'S20'
    fill_in 'product_message_text', with: 'Olá, tudo bem?'
    click_on 'Enviar'

    expect(page).to have_content('Mensagens')
    expect(page).to have_content('Joao Neves Silva')
    expect(page).to have_content('TI')
    expect(page).to have_content('Olá, tudo bem?')
  end

  scenario 'buyer send message' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    buyer = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    seller = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: seller)

    login_as buyer
    visit root_path
    click_on 'S20'
    fill_in 'product_message_text', with: 'Olá, tudo bem?'
    click_on 'Enviar'

    expect(page).to have_content('Mensagens')
    expect(page).to have_content('Victor Neves Silva')
    expect(page).to have_content('Tecnologia')
    expect(page).to have_content('Olá, tudo bem?')
  end


  scenario 'send null message' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    buyer = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    seller = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b', full_name: 'Joao Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'TI')
    product = Product.create!(name: 'S20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: seller)
    
    login_as buyer
    visit root_path
    click_on 'S20'
    click_on 'Enviar'

    expect(page).to have_content('A mensagem não pode estar vazia')
  end
end
