*** Settings ***
Documentation     Helpers.

*** Keywords ***
## Is
Is Registro cadastrado by name
    [Documentation]        Verifica se o item foi cadastrado, relaizado um wher no nome do atributo
    [Arguments]    ${SCHEMA_TABELA_NAME}    ${TABLE_ATRIBUTO}    ${VALOR}
    
    BasePage.Conecta no Banco Oracle
    Row Count Is Equal To X     select ${TABLE_ATRIBUTO} from ${SCHEMA_TABELA_NAME} where upper(${TABLE_ATRIBUTO})=upper('${VALOR}')     1
    BasePage.Disconnect From DB

## DEL
Deletar registro da "${TABELA}" com o campo "${CAMPO}" que contém o valor "${VALOR}"
    BasePage.Conecta no Banco Oracle
    Execute SQL String    DELETE FROM ${TABELA} WHERE UPPER(${CAMPO})=UPPER('${VALOR}')
    BasePage.Disconnect From DB

Del registro by name
    [Arguments]    ${SCHEMA_TABELA_NAME}    ${TABLE_ATRIBUTO}    ${VALOR}

    BasePage.Conecta no Banco Oracle
    Execute SQL String    DELETE FROM ${SCHEMA_TABELA_NAME} WHERE UPPER(${TABLE_ATRIBUTO})=UPPER('${VALOR}')
    BasePage.Disconnect From DB

##  GET
Retorna arquivo em Json
    [Documentation]     Função responsável por transformar uma string json em um objeto.

    [Arguments]     ${json_file}

    ${string_file}=        Get File    ${EXECDIR}/resources/fixtures/${json_file}
    ${jsob_object}=       Evaluate    json.loads($string_file)     json

    [Return]    ${jsob_object}

Get Arquivo Json
    [Arguments]     ${json_file}

    ${string_file}=         Get File    ${EXECDIR}/resources/fixtures/${json_file}
    ${jsob_object}=         Evaluate    json.loads($string_file)     json

    [Return]    ${jsob_object}

Get Mensagem de Sucesso 
    [Documentation]     Função responsável por válidar se a mensagem de sucesso
    ...                 está sendo retornada no campo correto, com a classe correta (.alert-success)
    ...                 caso não tenha passado nenhuma mensagem a mensagem padrão será
    ...                 Registro inserido com sucesso.

    [Arguments]     ${expected_message}=Registro inserido com sucesso.
    
    Set Focus To Element                css:.alert-success
    Wait Until Element Is Visible       css:.alert-success

    helpers.Get Quantidade de Mensagem de Sucesso

    Element Text Should Be              css:.alert-success     ${expected_message}
    sleep   2s


Get Quantidade de Mensagem de Sucesso   
    [Documentation]     Função utilizada para verificar se existe mais de uma mensagem de sucesso na tela
    ...                 Como controle para evitar erros caso ocorra de aparecer mais de uma mensagem

    Wait Until Element Is Visible       css:.alert-success
    @{elements}=    Get WebElements     css:.alert-success
    ${count}=   Get Length  ${elements}
    Run Keyword If      ${count}>1    Fatal Error     msg=Ops, esta sendo aprensentado mais de uma mensagem de sucesso.

Get Mensagem de Erro 
    [Arguments]     ${seletor}      ${expected_message}

    Wait Until Element Is Visible       ${seletor}
    @{elements}=    Get WebElements     ${seletor}

    FOR    ${element}   IN      @{elements}    
        ${text}=    Get Text    ${element} 
        Exit For Loop If    '${text}'=='${expected_message}'
        # Run Keyword If      '${text}'=='${expected_message}'    Return From Keyword     ${text}
    END
    Run Keyword If   '${text}'!='${expected_message}'   Fatal Error     msg=Mensagem, ${expected_message}, não encontrada.
    # Return From Keyword     ${EMPTY}

##  SET
Set Campo Input
    [Documentation]     Função reponsável por colocar valor no campo desejado

    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}

    sleep   2s
    Wait Until Page Contains Element    ${CAMPO_INPUT}
    Wait Until Element Is Visible       ${CAMPO_INPUT} 
    Set Focus To Element                ${CAMPO_INPUT} 
    Input Text      ${CAMPO_INPUT}      ${CAMPO_VALOR}      
    # para disparar os campos com isvalid
    Press Keys      ${CAMPO_INPUT}      TAB

Set Campo Input Data Javascript
    [Documentation]     Função reponsável por colocar valor no campo desejado via javascript
    ...                 e por um erro que estava dando no genexus, foi colocado para atribuir
    ...                 valor no atributo data-gx-oldvalue, utilizado para campos que possuem
    ...                 o date picker

    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}

    Sleep   1s  

    Wait Until Page Contains Element    ${CAMPO_INPUT}
    Wait Until Element Is Visible       ${CAMPO_INPUT}
    Set Focus To Element                ${CAMPO_INPUT}

    Execute Javascript      document.getElementById("${CAMPO_INPUT}").value="${CAMPO_VALOR}";
    Execute Javascript      document.getElementById("${CAMPO_INPUT}").setAttribute("data-gxoldvalue","${CAMPO_VALOR}");

    # para disparar os campos com isvalid
    Press Keys      ${CAMPO_INPUT}      TAB

Set Campo Input Javascript
    [Documentation]     Função reponsável por colocar valor no campo desejado via javascript
    ...                 pois os campos do tipo password e campos de transaction necessitavam
    ...                 de um input de valor mais hard


    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}

    Sleep   1s    
    Wait Until Page Contains Element    ${CAMPO_INPUT}
    Wait Until Element Is Visible       ${CAMPO_INPUT} 
    Set Focus To Element                ${CAMPO_INPUT} 
    #Input Text      ${CAMPO_INPUT}      ${CAMPO_VALOR}  
    Execute Javascript      document.getElementById("${CAMPO_INPUT}").value="${CAMPO_VALOR}";    
    # para disparar os campos com isvalid
    Press Keys      ${CAMPO_INPUT}      TAB

Set Campo Select
    [Documentation]     Função reponsável por selecionar um item de uma combobox

    [Arguments]     ${CAMPO_INPUT}      ${CAMPO_VALOR}
    Wait Until Element Is Visible   ${CAMPO_INPUT}
    Select From List By Value       ${CAMPO_INPUT}     ${CAMPO_VALOR}

Set Campo Checkbox Selecionado
    [Documentation]     Função reponsável por preencher valor em um campo checkbox

    [Arguments]     ${CAMPO_INPUT}
    Wait Until Keyword Succeeds         1 min   2s  Wait Until Element Is Visible       ${CAMPO_INPUT}  
    Wait Until Keyword Succeeds         1 min   2s  Select Checkbox                     ${CAMPO_INPUT}  
## ACTIONS CLICK
Clicar no Botão Confirmar
    [Documentation]     Função utilziada para clicar no botão confirmar, nas WT ou TM

    Wait Until Keyword Succeeds        30 s   1s  Wait Until Page Contains Element    css:input[title="Confirmar"]
    Wait Until Keyword Succeeds        30 s   1s  Click Element                       css:input[title="Confirmar"]

Clicar no Botão Inserir
    [Documentation]     Função utilziada para clicar no botão confirmar, nas WM ou WW(Selection)

    BasePage.Limpar filtros de pesquisa
    Sleep   2s
    Click Element                   id:BTNINSERT

Clicar no "${BUTTON}"
    [Documentation]     Função utilizada para clicar em um botão passando somente o seletor
    ...                 foi criada essa função para que não necessite mais de ficar passando as 3 keyword
    ...                 fazendo assim com que o codigo fique mais limpo
    
    Wait Until Element Is Visible       ${BUTTON}
    Wait Until Element Is Enabled       ${BUTTON}
    Wait Until Keyword Succeeds         30 s   1s  Click Button                        ${BUTTON}

Clicar no Link "${LINK}"
    [Documentation]     Função utilizada para clicar em um link

     Wait Until Keyword Succeeds        30 s   1s  Click Link     ${LINK}

Clicar no prompt by id
    [Arguments]     ${selector_prompt}

    Wait Until Element Is Visible      id:${selector_prompt}
    Wait Until Element Is Enabled      id:${selector_prompt}
    Wait Until Keyword Succeeds        30s   1s  Click Image     id:${selector_prompt}
    
Clicar na imagem by xpath
    [Arguments]     ${selector_xpath}

    Wait Until Keyword Succeeds        30s   1s  Wait Until Element Is Visible      xpath:${selector_xpath}          # //*[@id="vSELECT_0001"]
    Wait Until Keyword Succeeds        30s   1s  Wait Until Element Is Enabled      xpath:${selector_xpath}
    Wait Until Keyword Succeeds        30s   1s  Click Image     xpath:${selector_xpath}

Clicar no prompt by class
    [Arguments]     ${selector_prompt}

    Click Image     class:${selector_prompt}

## ACTIONS REDIRECT
Ir até a página "${PAGINA}"
    [Documentation]     Função utilizada para redirecionar para outra página do sistema

    Sleep       1s 
    Go To       ${BASE_URL}/servlet/${PAGINA} 
    Sleep       0.5s
      

## ACTIONS GENERICOS
## VALIDAÇÕES
Checagem de valor na grid
    [Arguments]    ${selecot}    ${valor}

    Wait Until Keyword Succeeds        60s   1s  Table Row Should Contain     ${selecot}    1    ${valor}