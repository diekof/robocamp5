*** Settings ***
Documentation     passos de configuração dos testes.

Resource          ../pages/BasePage.robot
Resource          ../pages/ST0002_UsuarioPage.robot

*** Variables ***
${SUITE_NAME}       ST0002_Usuario/

*** Keywords ***
Dado que eu tenha um novo usuário
    [Arguments]     ${dados_usuario}

    BasePage.Carregando arquivo de dados    ST0002_Usuario/${dados_usuario}  
    #Back To The Past
    ST0002_UsuarioPage.Deleta usuário pelo nome  ${acao_json['login']}  ${acao_json['nome']}  ${acao_json['cpf']}

    Sleep       1s  
Dado que eu não tenha informado nenhum usuário
    Log To Console      Nenhum usuário informado

Quando eu realizo o cadastro desse usuário
    helpers.Clicar no Botão Inserir
    helpers.Set Campo Input                     id:SDTCADUSUARIO_CPFCOMMASCARA          ${acao_json['cpf']}
    helpers.Set Campo Input                     id:SDTCADUSUARIO_PESNOME                ${acao_json['nome']}
    helpers.Set Campo Input Data Javascript     SDTCADUSUARIO_PESNASCIMENTO             ${acao_json['data_nascimento']}
    helpers.Set Campo Input                     id:SDTCADUSUARIO_PESEMAIL               ${acao_json['e_mail']}
    helpers.Set Campo Input                     id:SDTCADUSUARIO_USULOGIN               ${acao_json['login']} 
    (Des)Marcar checkbox ad                     ${acao_json['utiliza_ad']}              ${acao_json['senha']}               ${acao_json['cpf']}
    helpers.Set Campo Input                     id:W0066vPERFNOME                       ${acao_json['perfil']} 
    helpers.Set Campo Checkbox Selecionado      css:tbody .checkbox > label > input     
    helpers.Clicar no Botão Confirmar

Quando eu realizo o cadastro desse usuário vazio
    helpers.Clicar no Botão Inserir
    Sleep       2s
    helpers.Clicar no Botão Confirmar

Entao devo ver esse usuário na lista
    Sleep       1s
    ST0002_UsuarioPage.Checando se o usuário foi cadastrado no Banco           ${acao_json['login']}   

    helpers.Set Campo Input      vPESNOME1       ${acao_json['nome']}

E devo conseguir acessar ao sistema
    Sleep   1s
    helpers.Ir até a página "app.wlogin"
    ST0000_LoginPage.Login With             ${acao_json['login']}      ${acao_json['senha']}
    Sleep   2s
    Page Should Contain                 ${acao_json['login']}

Preencher campo senha e confirmação de senha
    [Arguments]     ${ususenha}     ${ususenhaconfirmacao}

    helpers.Set Campo Input Data Javascript     SDTCADUSUARIO_USUSENHA               ${ususenha}
    helpers.Set Campo Input Data Javascript     SDTCADUSUARIO_USUSENHACONFIRMAR      ${ususenhaconfirmacao}

(Des)Marcar checkbox ad
    [Arguments]     ${autentica_ad}     ${senha}    ${conf_senha}

    Run Keyword If   '${autentica_ad}'=='false'       Preencher campo senha e confirmação de senha     ${senha}  ${conf_senha}
    ...              ELSE       Select Checkbox     id:SDTCADUSUARIO_USUAUTENTICARAD 

