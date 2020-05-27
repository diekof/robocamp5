*** Settings ***
Documentation         Manutenção de Tags de Documentos

Resource           ../../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}      ${SENHA_GLOBAL}
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Test Cases ***
# TC01_Nova_Tag_Documento
Cenário 01: Cadastrando uma nova tag
    [tags]    smoke
    [Documentation]        Teste de cadastro de tag, preenchendo todos os campos da tela
    ...                    fazendo entao o cadastro dessa tag.

    Dado que eu tenha uma nova tag 
    ...    TC01_Nova_Tag_Documento.json          
    E acesso a tela de cadastro de tag
    Quando eu realizo o cadastro dessa tag
    Então devo ver a mensagem de sucesso
    ...    Registro salvo com sucesso.
    E devo ver essa tag na lista

Cenário 02: Editando uma tag
    [tags]    smoke
    [Documentation]     comentario legal futuramente, nao agora to cansado.

    Dado que eu tenha a seguinte tag cadastrada
    ...    TC02_Edita_Antes_Tag_Documento.json
    Quando eu realizo a alteração dessa tag para
    ...    TC02_Edita_Depois_Tag_Documento.json
    helpers.Get Mensagem de Sucesso   Registro salvo com sucesso.
    E devo ver essa tag na lista

Cenário 03: Excluir uma tag
    [tags]    smoke

    Dado que eu tenha que excluir uma tag
    ...    TC01_Exclusao_Tag_Documento.json  
    Quando realizo a exclusão desse registro
    Então devo ver a mensagem de excluído com sucesso
    E não devo ver esse registro na lista

Cenário 04: Desistir de excluir uma tag
    Dado que eu tenha que excluir uma tag
    ...    TC01_Desisitir_Exclusao_Tag_Documento.json  
    Quando não realizo a exclusão desse registro
    Então devo continuar vendo o registro na grid

# Cenário 05: Não informar nenhuma tag e clicar no confirmar


