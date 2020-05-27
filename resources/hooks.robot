*** Settings ***
Documentation     Helpes.

*** Keywords ***
Então devo ver a mensagem de sucesso
    [Arguments]     ${expected_message}

    helpers.Get Mensagem de Sucesso   ${expected_message}