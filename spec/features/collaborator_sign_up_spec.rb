require 'rails_helper'

feature 'Collaborator sign up a account' do
  scenario 'succesfully' do
    category = Category.create!(name: 'Celulares', description: 'ASDIKPOSDKOPKOPADKOPASD')
    Company.create!(domain: 'treinadev.com.br', name: 'Treina Dev')

    visit root_path
    click_on 'Cadastre-se'
    fill_in 'E-mail', with: 'victor@treinadev.com.br'
    fill_in 'Senha', with: '!a123456789b'
    fill_in 'Confirme sua senha', with: '!a123456789b'
    click_on 'Cadastrar'

    expect(page).to have_content 'Marketplace'
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'Treina Dev'
    expect(page).to have_content 'Encontre por categoria'
    expect(page).to have_content 'Celulares'
    expect(page).to_not have_content 'Produtos à venda'
  end

  scenario 'already registred' do
    Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b')

    visit root_path
    click_on 'Cadastre-se'
    fill_in 'E-mail', with: 'victor@treinadev.com.br'
    fill_in 'Senha', with: '!a123456789b'
    fill_in 'Confirme sua senha', with: '!a123456789b'
    click_on 'Cadastrar'

    expect(page).to have_content 'E-mail já está em uso'
    expect(page).to_not have_content 'Marketplace'
    expect(page).to_not have_content 'Você realizou seu registro com sucesso'
  end

  scenario 'incomplete form' do
    visit root_path
    click_on 'Cadastre-se'
    click_on 'Cadastrar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to_not have_content 'Marketplace'
    expect(page).to_not have_content 'Você realizou seu registro com sucesso'
  end
end
