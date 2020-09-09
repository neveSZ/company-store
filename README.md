# Projeto Final - Loja de Colaboradores

Esse projeto faz parte da primeira parte do programa de treinamento da 4ª turma do TreinaDev(Campus Code).

O projeto consiste em uma aplicação baseada em **Ruby on Rails** para criar uma plataforma web para anúncio, compra e venda de produtos de pessoas dentro uma mesma empresa.

Um esboço rápido do diagrama de classes pode ser acessado [aqui](./diagrams/class_diagram_sketch.png).

Um board do Trello está sendo utilizado para a elaboração do projeto, você pode acessa-lo nesse [link](https://trello.com/b/ruL0xNhc/projeto-treinadev).

## Instruções para executar
Para a execução do projeto é recomendável que você esteja na versão 2.7.0 do Ruby, utilizando a versão 6.0.3.2 do framework Rais e com o SQLite instalado.

Você pode instala-los através desses links:
* Ruby: https://www.ruby-lang.org/pt/downloads/
* Rails: https://guides.rubyonrails.org/v5.0/getting_started.html
* SQLite: https://www.sqlite.org/index.html

Assim que tudo estiver pronto execute os seguinte comandos para instalar as dependências e subir o banco de dados:
```
bundle install
yarn install
rails db:migrate
rails start
```
Em seguida acesse o servidor através do endereço `localhost:3000`

## Gems utilizadas
* [Capybara](https://github.com/teamcapybara/capybara) (capybara): para criação de testes de funcionalidade, integração e testes unitários;
* [Devise](https://github.com/heartcombo/devise) (devise): para realizar a autenticação dos colaboradores;
* [RSpec](https://github.com/rspec/rspec-rails) (rspec-rails): para a realização de testes de usabilidade/integração, simulando a utilização de um usuário na web;
* [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) (carrierwave): para fazer o upload das imagens dos anuncios.

## Testes de features utilizados
* [collaborator_buy_product](./spec/features/collaborator_buy_product.rb): colaborador realiza a compra de um produto;
* [collaborator_add_info](./spec/features/collaborator_add_info_spec.rb): colaborador completa as informações do seu perfil;
* [collaborator_announce_product](./spec/features/collaborator_announce_product_spec.rb): colaborador anuncia um produto;
* [collaborator_order_message](./spec/features/collaborator_order_message_spec.rb): colaborador envia ou recebe uma mensagem no pedido;
* [collaborator_product_message](./spec/features/collaborator_product_message_spec.rb): colaborador envia ou recebe uma mensagem no produto;
* [collaborator_search_product](./spec/features/collaborator_search_product_spec.rb): colaborador procura por um produto através do nome, categoria ou descrição;
* [collaborator_see_all_products_from_same_company](./spec/features/collaborator_see_all_products_from_same_company_spec.rb): colaborador visualiza a lista de produtos disponíveis na empresa dele;
* [collaborator_see_orders](./spec/features/collaborator_see_orders_spec.rb): colaborador visualiza a sua lista de pedidos;
* [collaborator_see_other_collaborator](./spec/features/collaborator_see_other_collaborator_spec.rb): colaborator acessa o perfil de outro colaborador;
* [collaborator_see_product_info](./spec/features/collaborator_see_product_info_spec.rb): colaborador visualiza as informações de um produto;
* [collaborator_sign_up_spec](./spec/features/collaborator_sign_up_spec.rb): colaborador se registra;
* [seller_change_order_status](./spec/features/seller_change_order_status_spec.rb): colaborador muda o status do pedido;
* [seller_change_product_status](./spec/features/seller_change_product_status_spec.rb): colaborador altera o status do produto.



