*** Settings ***
Documentation       Suíte de Exemplo de testes API com o Robot Framework
Resource            BDDpt-br.robot
Resource            Resource.robot

*** Test Case ***
Cenário 01: Consulta de comentarios existentes
    Que esteja conectado no webservice do jsonplaceholder
    Quando o usuario consultar os comentarios ""
    Deve ser mostrado a id "1"
    Deve ser mostrado o autor "1"
    Deve ser mostrada o nome "id labore ex et quam laborum"
    Deve ser mostrado o email do autor "Eliseo@gardner.biz"
    Deve ser mostrado o corpo do comentário "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"

Cenário 02: Cadastra um usuário
    Que esteja conectado no webservice do jsonplaceholder
    Quando Cadastrar um usuário ""
    Deve ser mostrado a identificacao "11"

Cenário 03: Atualiza um usuário
    Que esteja conectado no webservice do jsonplaceholder
    Quando Atualizar um usuário ""
    Deve ser mostrado a id do usuario "5"
