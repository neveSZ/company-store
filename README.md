# Projeto Final - Loja de Colaboradores

Esse projeto faz parte da primeira parte do programa de treinamento da 4ª turma do TreinaDev(Campus Code).

O projeto consiste em uma aplicação baseada em **Ruby on Rails** para criar uma plataforma web para anúncio, compra e venda de produtos de pessoas dentro uma mesma empresa.

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

## Testes utilizados
