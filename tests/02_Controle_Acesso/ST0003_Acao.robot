*** Settings ***
Documentation         ST0003 - Manutenção de Ações
...                   Funcionalidade de manutenção de Ações, deve-se ter um usuário e senha válidos 
...                   com acesso ao objeto tmacaoww e com as ações liberadas.
...                   Objeto: tmacaoww

Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}   ${SENHA_GLOBAL}
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Test Cases ***

# TC0001_Nova_Acao
Cenário 01: Nova ação  
    [Tags]      smoke
    Dado que eu tenha uma nova ação   TC0003_Nova_Acao.json
    Quando eu faço o cadastro de uma nova ação
    Então devo ver a mensagem de sucesso
    E devo ver esta ação na lista

# TC0002_Editar_Acao
Cenário 02: Editar ação 
    [Tags]      smoke
    Dado que eu tenho o seguinte produto cadastrado     TC0003_Editar_Acao_Antes.json   
    Quando eu faço a alteração da ação para             TC0003_Editar_Acao_Depois.json
    Então devo ver a mensagem de alterado com sucesso
    E ele deve ficar com os dados igualmente ao depois  TC0003_Editar_Acao_Depois.json

# TC0003_Excluir_Acao
Cenário 03: Excluir uma ação
    [Tags]      smoke
    Dado que eu tenha que excluir um registro       TC0003_Nova_Acao.json
    Quando realizo a exclusão desse registro
    Então devo ver a mensagem de excluído com sucesso
    E não devo ver esta ação na lista

# TC0004_Desistir_Exclusao
Cenário 04: Desistir de excluir uma ação
    [Tags]      smoke
    Dado que eu tenha que excluir um registro       TC0003_Nova_Acao.json
    Quando não realizo a exclusão desse registro
    Então devo ver esta ação na lista



