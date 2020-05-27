*** Settings ***
Documentation        TC_002_Usuario_Page
...                  Representa a página de cadastro de usaurio com todos os seus elementos
...                  E também suas funcionalidades

*** Variables ***

*** Keywords ***
Checando se o usuário foi cadastrado no Banco
    [Arguments]     ${usuario_login}
    
    BasePage.Conecta no Banco Oracle
    Row Count Is Equal To X     select usulogin from sisbase.TBUSUARIO where upper(usulogin)=upper('${usuario_login}')     1
    BasePage.Disconnect From DB

Deleta usuário pelo nome
    [Arguments]     ${usuario_login}    ${usuario_nome}     ${usuario_cpf}
    
    BasePage.Conecta no Banco Oracle
    Execute SQL String      CALL PCK_AUTOMACAO.PRC_EXCLUIR_USUARIO('${usuario_nome}','${usuario_login}',' ${usuario_cpf}')      True
    BasePage.Disconnect From DB
    