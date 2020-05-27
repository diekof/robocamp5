*** Settings ***
Documentation         ST0004
...                   Funcionalidade de manutenção de Ações, deve-se ter um usuário e senha válidos 
...                   com acesso ao objeto tmexcecaosenhaww e com as ações liberadas.
...                   Objeto: tmexcecaosenhaww

Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}   ${SENHA_GLOBAL}
Suite Teardown      Close Session

Test Teardown       Finalizando Teste
Test Template       Tentar cadastrar excessões   

*** Keywords ***
Tentar cadastrar excessões
    [Documentation]     Caso de teste para um cadastro de uma nova exceção de senha
    ...                 cadastrando um novo dado com a massa de dados.

    [Arguments]     ${json_file}    ${expected_message}

    Dado que eu tenha uma nova execeção de senha        ${json_file}
    Quando eu realizo o cadastro dessa execeção
    E devo ver a mensagem de alerta                     ${expected_message}

*** Test Cases ***
Cenário 01: Descrição não informada         ST0004_TC01_sem_descricao.json        Campo Descrição é de preenchimento obrigatório.
Cenário 02: Senha não informada             ST0004_TC01_sem_senha.json            Campo Senha é de preenchimento obrigatório.

