require 'rails_helper'

feature 'Collaborator fills all profile information' do
  scenario 'successfully on more info page' do
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b')

    login_as collaborator
    visit root_path
    click_on 'Completar informações'
    fill_in 'Nome completo', with: 'Victor Neves Silva'
    fill_in 'Nome social', with: 'Daniela Neves Silva'
    fill_in 'Data de nascimento', with: '13/07/2000'
    fill_in 'Cargo', with: 'Analista'
    fill_in 'Setor', with: 'Tecnologia'
    click_on 'Confirmar'

    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
    expect(page).to_not have_content('Completar informações')
  end

  scenario 'successfully in product page' do
    category = Category.create!(name: 'Celulares', description: 'teste categoria')
    seller = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')
    collaborator = Collaborator.create!(email: 'joao@treinadev.com.br', password: '!a123456789b')
    Product.create!(name: 'SAM20', category: category, description: 'teste produto', value: 10.00, status: 0, collaborator: seller)

    login_as collaborator
    visit root_path
    click_on 'SAM20'
    click_on 'Comprar'

    expect(page).to have_content('Para fazer um pedido complete seu cadastro')
  end

  scenario 'incomplete infos' do
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b')

    login_as collaborator
    visit root_path
    click_on 'Completar informações'
    fill_in 'Nome social', with: 'Daniela Neves Silva'
    fill_in 'Data de nascimento', with: '13/07/2000'
    fill_in 'Setor', with: 'Tecnologia'
    click_on 'Confirmar'

    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
    expect(page).to have_content('Completar informações')
  end

  scenario 'dont fill full name, but fill social name' do
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b')

    login_as collaborator
    visit root_path
    click_on 'Completar informações'
    fill_in 'Nome social', with: 'Daniela Neves Silva'
    fill_in 'Data de nascimento', with: '13/07/2000'
    fill_in 'Cargo', with: 'Analista'
    fill_in 'Setor', with: 'Tecnologia'
    click_on 'Confirmar'

    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
    expect(page).to_not have_content('Completar informações')
  end
end
