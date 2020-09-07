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

  xscenario 'successfully in product page' do
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
