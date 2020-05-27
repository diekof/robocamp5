*** Settings ***
Documentation     Passos de configuração dos testes de organograma.

Resource          ../pages/BasePage.robot

***Keywords***
Dado que eu tenha uma nova estrutura administrativa do tipo formal
    [Arguments]     ${json_file}

    BasePage.Carregando arquivo de dados    Organograma/${json_file}
    # devo ir até a página listagem de organogramas
    helpers.Ir até a página "app.quartzo.tmorganogramaww?1"

Quando eu realizo o cadastro desse estrutura

    Sleep   2s
    helpers.Clicar no Botão Inserir

    helpers.Set Campo Input     id:ORGNNOME         ${acao_json['ORGNNOME']}
    helpers.Set Campo Input     id:ORGNSIGLA        ${acao_json['ORGNSIGLA']}
    # clicando no prompt
    helpers.Set Campo Input     id:PJID             ${acao_json['PJID']}  
    #helpers.Clicar no prompt by id  
    #...     BT_PROMPTPJ
    #helpers.Clicar na imagem by xpath 
    #...      //*[@id="vSELECT_0001"]
    #helpers.Clicar no prompt by id  vSELECT_0001
    #helpers.Clicar no "id:BT_PROMPTPJ"
    #helpers.Clicar no Link "id:BT_PROMPTPJ"
    #helpers.Clicar no Link "xpath://*[@id="vSELECT_0001"]"

    helpers.Set Campo Input Data Javascript     ORGNDTAINICIO    ${acao_json['ORGNDTAINICIO']}

    helpers.Clicar no Botão Confirmar

E devo ver essa estrutura na lista
    helpers.Set Campo Select    id:vORGNESTRUTURA               1
    helpers.Set Campo Select    id:vDYNAMICFILTERSSELECTOR1     ORGNNOME
    helpers.Set Campo Input     id:vORGNNOME1                   ${acao_json['ORGNNOME']}
    Sleep   2s
    #verificando se o item esta na grid
    Table Row Should Contain    css:.ygtvitem > table   1   ${acao_json['ORGNNOME']}
    
