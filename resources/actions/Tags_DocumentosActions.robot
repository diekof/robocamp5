*** Settings ***
Documentation     passos de configuração dos testes.

Resource          ../pages/BasePage.robot

***Keywords***
Dado que eu tenha uma nova tag 
    [Arguments]     ${json_string}

    BasePage.Carregando arquivo de dados    TagsDocumentos/${json_string}
    helpers.Ir até a página "app.quartzo.tmtagdocumentoww"

Dado que eu tenha a seguinte tag cadastrada
    [Arguments]     ${json_string}

    Registrando uma nova tag
    ...     ${json_string}

Dado que eu tenha que excluir uma tag
    [Arguments]     ${json_string}

    Registrando uma nova tag
    ...     ${json_string}

E acesso a tela de cadastro de tag

    Deletar tag cadastrada    
    ...    ${acao_json['TAGNOME']}
    helpers.Clicar no Botão Inserir

Quando eu realizo o cadastro dessa tag

    helpers.Set Campo Select    id:SISID            ${acao_json['SISID']}
    helpers.Set Campo Input     id:TAGNOME          ${acao_json['TAGNOME']}
    helpers.Set Campo Input     id:TAGDESCRICAO     ${acao_json['TAGDESCRICAO']}

    helpers.Clicar no Botão Confirmar

Quando eu realizo a alteração dessa tag para
    [Arguments]     ${json_string}

    helpers.Clicar no "css:button[data-id="vGRIDACTIONS_0001"]"
    helpers.Clicar no Link "${EDITAR_GRID}"

    BasePage.Carregando arquivo de dados    TagsDocumentos/${json_string}
    Deletar tag cadastrada    
    ...    ${acao_json['TAGNOME']}

    helpers.Set Campo Select    id:SISID            ${acao_json['SISID']}
    helpers.Set Campo Input     id:TAGNOME          ${acao_json['TAGNOME']}
    helpers.Set Campo Input     id:TAGDESCRICAO     ${acao_json['TAGDESCRICAO']}

    helpers.Clicar no Botão Confirmar

E devo ver essa tag na lista
    helpers.Set Campo Input    id:vTAGNOME1    ${acao_json['TAGNOME']}
    # verificando se o item esta na grid maneira 1
    helpers.Checagem de valor na grid            id:GridContainerTbl    ${acao_json['TAGNOME']}
    # verificando se o item esta no banco de dados
    # helpers.Is Registro cadastrado by name       SISBASE.TBTAGDOCUMENTO    TAGNOME    ${acao_json['TAGNOME']}
    Verificando se a tag foi cadastrada

E não devo ver esse registro na lista
    ${passed} =     Run Keyword And Return Status  Verificando se a tag foi cadastrada
    Run Keyword If      '${passed}'=='True'    Fatal Error     msg=O registro ainda se encotnra na consula.

Deletar tag cadastrada 
    [Arguments]    ${TAG_NOME}

    helpers.Del registro by name    
    ...    SISBASE.TBTAGDOCUMENTO    TAGNOME    ${TAG_NOME}

Então devo continuar vendo o registro na grid
    E devo ver essa tag na lista
    
Verificando se a tag foi cadastrada
     helpers.Is Registro cadastrado by name       SISBASE.TBTAGDOCUMENTO    TAGNOME    ${acao_json['TAGNOME']}

Registrando uma nova tag
    [Arguments]    ${json_string}

    Dado que eu tenha uma nova tag     ${json_string}
    E acesso a tela de cadastro de tag
    Quando eu realizo o cadastro dessa tag
    Então devo ver a mensagem de sucesso
    ...    Registro salvo com sucesso.
    E devo ver essa tag na lista

    

