***Settings***
Documentation       Aqui teremos todas a palavras de ação dos testes autoamtizados

Library     SeleniumLibrary

***Keywords***
## helpers
Open Chrome
    Open Browser        http://pixel-web:3000     chrome    options=add_experimental_option('excludeSwitches', ['enable-logging'])

## hooks
Open Session
    Open Chrome
    Set Window Size     1440    900

Close Session
    Close Browser

Clear Local Storage
    Execute Javascript      localStorage.clear();

End Test
    Capture Page Screenshot

## steps
Dado que acesso a página login
    Go To       http://pixel-web:3000/login

Quando submeto minhas credenciais "${email}" e "${pass}"
    Input Text      id:emailId      ${email}
    Input Text      id:passId       ${pass}
    Click Element   xpath://button[text()='Entrar']

Então devo ser autenticado
    Wait Until Element Is Visible       css:.user .info span
    Element Text Should Be              css:.user .info span      Papito
    
Então devo ver a mensagem de alerta "${expect_alert}"
    Wait Until Element Is Visible       class:alert
    Element Text Should Be              class:alert     ${expect_alert}