*** Settings ***
Documentation     passos de configuração dos testes.

Resource          ../pages/BasePage.robot
Resource          ../pages/ST0003_AcaoPage.robot

***Variables***
${EXCLUIR_GRID}     xpath://*[@id="GridContainerRow_0001"]/td[1]/div/div/ul/li[4]/a
${EDITAR_GRID}      xpath://*[@id="GridContainerRow_0001"]/td[1]/div/div/ul/li[3]/a


***Keywords***
Dado que eu tenha uma nova ação
    [Arguments]     ${json_file}

    BasePage.Carregando arquivo de dados    ST0003_Acao/${json_file} 
    helpers.Ir até a página "app.quartzo.tmacaoww"

Dado que eu tenha que excluir um registro
    [Arguments]      ${json_file}

    Registrando uma nova ação   ${json_file}

Dado que eu tenho o seguinte produto cadastrado
    [Arguments]      ${json_file}

    Registrando uma nova ação   ${json_file}

Quando eu faço a alteração da ação para
    [Arguments]      ${json_file}

    

    helpers.Clicar no "css:button[data-id="vGRIDACTIONS_0001"]"
    helpers.Clicar no Link "${EDITAR_GRID}"

    BasePage.Carregando arquivo de dados    ST0003_Acao/${json_file} 
    
    ST0003_AcaoPage.Deleta acao pelo nome  ${acao_json['acaonome_q']}
    helpers.Set Campo Input      id:ACAONOME_Q       ${acao_json['acaonome_q']}
    helpers.Set Campo Input      id:ACAODESC_Q       ${acao_json['acaodesc_q']}
    BasePage.E devo clicar no botão confirmar

Quando eu faço o cadastro de uma nova ação  

    BasePage.E devo clicar no botão inserir
    ST0003_AcaoPage.Deleta acao pelo nome  ${acao_json['acaonome_q']}     ##.Deleta acao pelo nome           ${acao_json['acaonome_q']}

    helpers.Set Campo Select     id:ACAOSISID_Q      ${acao_json['acaosisid_q']}
    helpers.Set Campo Input      id:ACAONOME_Q       ${acao_json['acaonome_q']}
    helpers.Set Campo Input      id:ACAODESC_Q       ${acao_json['acaodesc_q']}
    BasePage.E devo clicar no botão confirmar

Quando realizo a exclusão desse registro
    helpers.Clicar no "css:button[data-id="vGRIDACTIONS_0001"]"
    helpers.Clicar no Link "${EXCLUIR_GRID}"
    # validação para verificar se o item que eu selecionei esta Codigo - Descrição

    helpers.Clicar no "class:btn-yes-DVelop"

Quando não realizo a exclusão desse registro
    helpers.Clicar no "css:button[data-id="vGRIDACTIONS_0001"]"
    helpers.Clicar no Link "${EXCLUIR_GRID}"
    helpers.Clicar no "class:btn-no-DVelop"

E devo ver esta ação na lista
    ST0003_AcaoPage.Checando se o item foi cadastrado no Banco          ${acao_json['acaonome_q']}
    helpers.Set Campo Input  id:vACAONOME_Q1  ${acao_json['acaonome_q']}

Registrando uma nova ação
    [Arguments]      ${json_file}

    Dado que eu tenha uma nova ação     ${json_file}
    Quando eu faço o cadastro de uma nova ação
    Então devo ver a mensagem de sucesso
    E devo ver esta ação na lista

Então devo ver a mensagem de alterado com sucesso
    helpers.Get Mensagem de Sucesso   Registro atualizado com sucesso.

Então devo ver a mensagem de excluído com sucesso
    helpers.Get Mensagem de Sucesso   Registro excluído com sucesso.

E não devo ver esta ação na lista
    ${passed} =     Run Keyword And Return Status  ST0003_AcaoPage.Checando se o item foi cadastrado no Banco  ${acao_json['acaonome_q']}
    Run Keyword If      '${passed}'=='True'    Fatal Error     msg=O registro ainda se encotnra na consula.

Então devo ver esta ação na lista
    E devo ver esta ação na lista

E ele deve ficar com os dados igualmente ao depois
    [Arguments]     ${json_file}

    BasePage.Carregando arquivo de dados    ST0003_Acao/${json_file} 
    E devo ver esta ação na lista
    