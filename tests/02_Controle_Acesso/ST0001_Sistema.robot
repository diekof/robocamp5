*** Settings ***
Documentation         Manutenção de Sistemas
...                   Funcionalidade de manutenção de sistemas, deve-se ter um usuário e senha válidos 
...                   com acesso ao objeto wmsistema e com as ações liberadas.

Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}      ${SENHA_GLOBAL}
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Test Cases ***
Cenário 01: Novo Sistema  
    [Tags]      smoke
    Log To Console      Ola