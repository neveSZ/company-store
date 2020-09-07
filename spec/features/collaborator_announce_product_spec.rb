require 'rails_helper'

feature 'Collaborator announce a product' do
  scenario 'succesfully' do
    Category.create!(name: 'Celulares', description: 'ASDIKPOSDKOPKOPADKOPASD')
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')

    login_as collaborator
    visit root_path
    click_on 'Anunciar'
    fill_in 'Nome', with: 'S30'
    select 'Celulares', from: 'Categoria'
    attach_file('product_images', ['spec/files/images/1.jpg', 'spec/files/images/2.jpg', 'spec/files/images/3.jpg'])
    fill_in 'Descrição', with: 'teste teste'
    fill_in 'Valor', with: '100.00'
    click_on 'Concluir'

    expect(page).to have_content('Anuncio criado com sucesso')
    expect(page).to have_content('S30')
  end

  scenario 'incomplete form' do
    collaborator = Collaborator.create!(email: 'victor@treinadev.com.br', password: '!a123456789b', full_name: 'Victor Neves Silva', birth_date: '13/07/2000', role: 'Analista', department: 'Tecnologia')

    login_as collaborator
    visit root_path
    click_on 'Anunciar'
    click_on 'Concluir'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  scenario 'without login' do
    visit new_product_path

    expect(page).to have_content('Para continuar, faça login')
  end
end
