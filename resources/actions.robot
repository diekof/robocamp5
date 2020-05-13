***Settings***
Documentation       Aqui teremos todas a palavras de ação dos testes autoamtizados

Library             SeleniumLibrary

#arquivo de variaveis utilizadas na suite
Resource            elements.robot

***Keywords***
## helpers
Open Chrome
    Open Browser        ${BASE_URL}     chrome    options=add_experimental_option('excludeSwitches', ['enable-logging'])

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
    Go To       ${BASE_URL}/login

Quando submeto minhas credenciais "${email}" e "${pass}"
    Input Text      ${CAMPO_EMAIL}      ${email}
    Input Text      ${CAMPO_PWD}        ${pass}
    Click Element   ${BT_ENTRAR}

Então devo ser autenticado
    Wait Until Element Is Visible       ${CSS_USER_INFO}
    Element Text Should Be              ${CSS_USER_INFO}      Papito
    
Então devo ver a mensagem de alerta "${expect_alert}"
    Wait Until Element Is Visible       ${CSS_ALERTA}
    Element Text Should Be              ${CSS_ALERTA}     ${expect_alert}