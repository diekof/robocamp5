*** Settings ***
Documentation     passos de configuração dos testes.

Resource          ../pages/BasePage.robot

***Keywords***
Dado que eu tenha uma nova execeção de senha
    [Arguments]     ${json_file}

    BasePage.Carregando arquivo de dados    ST0004/${json_file} 
    helpers.Ir até a página "app.quartzo.tmexcecaosenhaww"   

Quando eu realizo o cadastro dessa execeção
    # função para deletar as informações do banco.
    Deleta execeção pelo nome           ${acao_json['descricao']}

    helpers.Clicar no Botão Inserir
    helpers.Set Campo Select    id:SISID                        ${acao_json['sistema_id']}
    helpers.Set Campo Input     id:EXCECAOSENHADESCRICAO        ${acao_json['descricao']}
    helpers.Set Campo Input     id:EXCECAOSENHANUM              ${acao_json['senha']}
    helpers.Clicar no Botão Confirmar

E devo ver a mensagem de sucesso custom
    helpers.Get Mensagem de Sucesso   Registrado com sucesso.
    
E devo ver esta execeção na lista
    Checando se a execeção foi cadastrado no Banco          ${acao_json['descricao']}

    BasePage.Preencher campo input  id:vEXCECAOSENHADESCRICAO1  ${acao_json['descricao']}
    sleep       2s

E devo ver a mensagem de alerta
    [Arguments]     ${expected_message}
    helpers.Get Mensagem de Erro   class:ErrorMessages     ${expected_message}

Checando se a execeção foi cadastrado no Banco
    [Arguments]     ${descricao}
    
    BasePage.Conecta no Banco Oracle
    Row Count Is Equal To X     SELECT * FROM SISBASE.TBEXCECAOSENHA WHERE upper(EXCECAOSENHADESCRICAO)=upper('${descricao}')     1
    BasePage.Disconnect From DB

Deleta execeção pelo nome
    [Arguments]     ${descricao}
    
    BasePage.Conecta no Banco Oracle
    Execute SQL String      DELETE FROM SISBASE.TBEXCECAOSENHA WHERE upper(EXCECAOSENHADESCRICAO)=upper('${descricao}')
    BasePage.Disconnect From DB