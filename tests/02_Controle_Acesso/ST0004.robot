*** Settings ***
Documentation         ST0004
...                   Funcionalidade de manutenção de exceções de senha, deve-se ter um usuário e senha válidos 
...                   com acesso ao objeto tmexcecaosenhaww e com as ações liberadas.
...                   Objeto: tmexcecaosenhaww

Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}   ${SENHA_GLOBAL}
Suite Teardown      Close Session
Test Teardown    Finalizando Teste

*** Test Cases ***
Cenário 01: Criação de nova execeção de senha   
    [Documentation]     Caso de teste para um cadastro de uma nova exceção de senha
    ...                 cadastrando um novo dado com a massa de dados.

    Dado que eu tenha uma nova execeção de senha        ST0004_TC01_Novo.json
    Quando eu realizo o cadastro dessa execeção
    E devo ver a mensagem de sucesso custom
    E devo ver esta execeção na lista