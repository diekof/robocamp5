*** Settings ***
Documentation        BasePage
...                  Representa a inicialização do Selenium e demais cursos como ganchos e helpers.

# bibliote do motor do selenium
Library               SeleniumLibrary
# biblioteca geral
Library               OperatingSystem
# biblioteca de conexao com o banco
Library               DatabaseLibrary
# biblioteca de captura de video
Library               ScreenCapLibrary

*** Variables ***
${SERVER_PROTOCOLO}     https
${SERVER_URL}           homologacao.abaco.com.br    #localhost   #homologacao.abaco.com.br
${SERVER_PORTA}         #:8080
${SISTEMA}              bh_prod_tst_quartzo     #local_dsv_quartzo       #bh_prod_tst_quartzo     #
${DIR_IMAGES}           screenshots
${BASE_URL}             ${SERVER_PROTOCOLO}://${SERVER_URL}${SERVER_PORTA}/${SISTEMA}
${LOGIN URL}            ${BASE_URL}/servlet/app.wlogin
${BROWSER}              chrome
${DELAY}                0
${USUARIO_GLOBAL}       admin_geral
${SENHA_GLOBAL}         abacoaba
${CHROME_OPTIONS}       options=add_experimental_option('excludeSwitches',['enable-logging'])
${DB_CONNECT_STRING}    'sisbase/abacoaba@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=bh-scan.abaco.com.br)(PORT=1521))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=PDBBHT01)))'


*** Keywords ***
## helpers
Open Chrome
    Open Browser                    ${LOGIN URL}      chrome    #options=add_experimental_options('excludeSwitches',['enable-logging'])

Open Session
    Open Chrome
    Set Window Size                 1440    900
    Set Selenium Implicit Wait      10 s
    Set Browser Implicit Wait       10 s
    Start Video Recording

Close Session   
    Close Browser

    # função de finalizacao da gracao de video
    Stop Video Recording

Finalizando Teste
    Capture Page Screenshot

Login Session
    [Arguments]     ${usuer}       ${pass}
    
    # função de gracao de video
    # Start Video Recording

    Open Session
    Login With      ${usuer}      ${pass}

Conecta no Banco SQLite
    Connect To Database Using Custom Params     sqlite3     database="db/development.sqlite3", isolation_level=None

Conecta no Banco Oracle
    #Connect to DB
    #Connect To Database      ${ORACLE DATABASE DRIVER}      ${ORACLE DATABASE URL}  ${ORACLE DATABASE USER}   ${ORACLE DATABASE PASSWORD}
    connect to database using custom params     cx_Oracle       ${DB_CONNECT_STRING}

Disconnect From DB
    #Disconnect from DB
    disconnect from database

E devo ver a mensagem de sucesso
    Wait Until Element Is Visible       css:.alert-success
    Element Text Should Be              css:.alert-success     Registro inserido com sucesso.
    Mouse Over                          css:.alert-success
    Set Focus To Element                css:.alert-success
    ${Mensagem_Close}=      Get WebElement     css:span[title="Close"]
    Click Element   ${Mensagem_Close}
    #helpers.Clicar no Link "css:span[title="Close"]"
    #helpers.Clicar no "css:span[title="Close"]"

Checando numero de mensagem sucesso
    [Arguments]     ${seletor}
    
    Wait Until Element Is Visible       css:.alert-success
    @{elements}=    Get WebElements     css:.alert-success
    #checando se esta aparecendo somente uma mensagem de suscesso
    Log Many    @{elements}
    ${count}=    Get Element Count     ${seletor}
    Should Be True      '${count}'=='1'
    #Should Not Be Equal As Numbers  ${count}
    #Should Be Equal As Numbers      
    #Should Be True      ${count}==1
    #Should Be Equal As Integers      ${count}   ${1}

#Então devo ver a mensagem de sucesso
#    E devo ver a mensagem de sucesso

Carregando arquivo de dados
    [Arguments]     ${json_file}

    ${acao_json}=   helpers.Retorna arquivo em Json     ${json_file}
    Set Test Variable      ${acao_json}
    Sleep   2

E acesso a funcionalidade  
    [Arguments]     ${tela_de_acesso}

    Sleep       2s
    Go To       ${BASE_URL}/servlet/${tela_de_acesso}    

E devo clicar no botão inserir
    helpers.Clicar no Botão Inserir

E devo clicar no botão confirmar
    helpers.Clicar no Botão Confirmar

Preencher campo input
    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}
    Sleep   1s
    
    Wait Until Page Contains Element    ${CAMPO_INPUT}
    Wait Until Element Is Visible       ${CAMPO_INPUT} 
    Set Focus To Element                ${CAMPO_INPUT} 

    Input Text      ${CAMPO_INPUT}      ${CAMPO_VALOR}  
    
    # para disparar os campos com isvalid
    Press Keys      ${CAMPO_INPUT}      TAB

Preencher campo input hard
    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}
    Sleep   1s
    
    Wait Until Page Contains Element    ${CAMPO_INPUT}
    Wait Until Element Is Visible       ${CAMPO_INPUT} 
    Set Focus To Element                ${CAMPO_INPUT} 

    #Input Text      ${CAMPO_INPUT}      ${CAMPO_VALOR}  
    Execute Javascript      document.getElementById("${CAMPO_INPUT}").value="${CAMPO_VALOR}";
    
    # para disparar os campos com isvalid
    Press Keys      ${CAMPO_INPUT}      TAB

Preencher campo data
    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}
    Sleep   1s  

    Wait Until Page Contains Element    ${CAMPO_INPUT}
    Wait Until Element Is Visible       ${CAMPO_INPUT}

    Execute Javascript      document.getElementById("${CAMPO_INPUT}").value="${CAMPO_VALOR}";
    Execute Javascript      document.getElementById("${CAMPO_INPUT}").setAttribute("data-gxoldvalue","${CAMPO_VALOR}");

    # para disparar os campos com isvalid
    Press Keys      ${CAMPO_INPUT}      TAB

E devo ver a mensagem de erro
    [Arguments]     ${expected_message}

    Wait Until Element Is Visible       css:.alert-danger
    @{elements}=    Get WebElements     css:.alert-danger

    ${mensagem_retorno}=    Checando se a mensagem esta na lista    ${expected_message}     @{elements}
    Should Be True   '${expected_message}'=='${mensagem_retorno}'
   
Checando se a mensagem esta na lista
    [Arguments]     ${expected_message}      @{elements} 

    FOR    ${element}   IN      @{elements}    
        ${text}=    Get Text    ${element} 
        Run Keyword If      '${text}'=='${expected_message}'    Return From Keyword     ${text}
    END
    Return From Keyword     ${EMPTY}

Limpar filtros de pesquisa
    Click Element       id:DDO_MANAGEFILTERSContainer_btnGroupDrop
    Click Link          css:ul[aria-labelledby="DDO_MANAGEFILTERSContainer_btnGroupDrop"] > li > a 
     
