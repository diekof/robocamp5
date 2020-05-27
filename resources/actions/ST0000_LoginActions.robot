*** Settings ***
Documentation     passos de configuração dos testes.

Resource          ../pages/BasePage.robot
Resource          ../pages/Components.robot
Resource          ../pages/ST0000_LoginPage.robot

*** Keywords ***
Dado que eu acesse a página inicial
    Go To        ${LOGIN URL}
      
Então Devo ser autenticado
    Wait Until Element Is Visible       ${TEXT_LABEL}
    Title Should Be                     Início
    Set Browser Implicit Wait           5
    Page Should Contain                 ${LOGGED_USUARIO}

Quando Faço o Login com 
    [Arguments]    ${login}      ${password}  
      
    ST0000_LoginPage.Login With    ${login}    ${password}    
    Set Global Variable     ${LOGGED_USUARIO}   ${login}

Então Devo ver a mensagem de alerta "${MSG_ALERTA}"
    Page Should Contain             ${MSG_ALERTA}

E Devo ver a mensagem de alerta "${MSG_ALERTA}"
    Então Devo ver a mensagem de alerta "${MSG_ALERTA}"

