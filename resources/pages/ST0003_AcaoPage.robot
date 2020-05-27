*** Settings ***
Documentation        TC_003_Acao_Page
...                  Representa a página de cadastro de ações com todos os seus elementos
...                  E também suas funcionalidades

*** Variables ***
${BT_INSERIR}     id:BTNINSERT

***Keywords***
Deleta acao pelo nome
    [Arguments]     ${ACAONOME_Q}
    
    BasePage.Conecta no Banco Oracle
    Execute SQL String      DELETE FROM sisbase.tbacao_q where upper(ACAONOME_Q)=upper('${ACAONOME_Q}')
    BasePage.Disconnect From DB

Checando se o item foi cadastrado no Banco
    [Arguments]     ${ACAONOME_Q}
    
    BasePage.Conecta no Banco Oracle
    Row Count Is Equal To X     select acaonome_q from sisbase.tbacao_q where upper(ACAONOME_Q)=upper('${ACAONOME_Q}')     1
    BasePage.Disconnect From DB