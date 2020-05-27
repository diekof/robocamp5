*** Settings ***
Documentation         Acesso ao sistema, teste de funcionalidade, "LOGIN ACESSO"
...                   Funcionalidade de login do sistema, deve-se ter um usuário e senha válidos 
...                   para conseguir acessar a tela inicial do sistema
...                   novo comentario de testes
...                   comentario

Resource           ../../resources/actions.robot

Suite Setup      Open Session
Suite Teardown   Close Session
Test Teardown    Finalizando Teste

*** Test Cases ***
Cenário 01: Login Correto
    [Tags]    smoke
    Dado que eu acesse a página inicial
    Quando Faço o Login com 
    ...    diego.silva    abacoaba
    Então Devo ser autenticado

Cenário 02: Senha Errada
    [Tags]    validacoes
    [Template]    Tentativa de Login  
    diego.silva    grp    Senha inválida.

Cenário 03: Login 404
    [Tags]    validacoes
    [Template]    Tentativa de Login  
    batatinha    grp    Usuário não cadastrado.

Cenário 04: Usuário vazio
    [Tags]    validacoes
    [Template]    Tentativa de Login  
    ${EMPTY}    123    O campo login é obrigatório.
    
Cenário 05: Senha vazia
    [Tags]    validacoes
    [Template]    Tentativa de Login  
    diego.silva    ${EMPTY}    O campo senha é obrigatório.

Cenário 06: Usuário e Senha vazios
    [Tags]    validacoes
    Dado que eu acesse a página inicial
    Quando Faço o Login com 
    ...    ${EMPTY}    ${EMPTY}    
    Então Devo ver a mensagem de alerta "O campo login é obrigatório."
    E Devo ver a mensagem de alerta "O campo senha é obrigatório."

*** Keywords ***
Tentativa de Login    
    [Arguments]    ${username}    ${password}    ${expected_message}

    Dado que eu acesse a página inicial
    Quando Faço o Login com 
    ...    ${username}      ${password}
    Então Devo ver a mensagem de alerta "${expected_message}"
