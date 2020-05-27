*** Settings ***
Documentation         Manutenção de Tags de Documentos
...                   Objeto: app.quartzo.tmtagdocumentoww

Resource           ../../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}   ${SENHA_GLOBAL}
Suite Teardown      Close Session

Test Teardown       Finalizando Teste
Test Template       Tentativa de cadastro de tags

***Keywords***
Tentativa de cadastro de tags
    [Documentation]     Caso de teste para um cadastro de uma nova tag

    [Arguments]     ${json_massa_testes}    ${expected_message}

    Dado que eu tenha uma nova tag          ${json_massa_testes}
    E acesso a tela de cadastro de tag
    Quando eu realizo o cadastro dessa tag
    E devo ver a mensagem de alerta         ${expected_message}

*** Test Cases ***
Cenário 01: Nome não informado        
...    TC01_Sem_Nome_Tag_Documento.json         Campo Nome é de preenchimento obrigatório.
Cenário 02: Descrição não informado    
...    TC01_Sem_Descricao_Tag_Documento.json    Campo Descrição é de preenchimento obrigatório.
# Cenário 03: Nome e Descrição não informado    
# ...    TC01_Sem_Descricao_Tag_Documento.json    Campo Descrição é de preenchimento obrigatório.
