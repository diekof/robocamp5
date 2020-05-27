*** Settings ***
Documentation         Organograma
...                   Objeto: tmorganogramaww?1

Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}   ${SENHA_GLOBAL}
Suite Teardown      Close Session

Test Teardown       Finalizando Teste
Test Template       Tentar cadastrar organograma

***Keywords***
Cenário 02: Tentar cadastrar organograma
    [Documentation]     Caso de teste para um cadastro de uma novo organograma
    ...                 administrativo do tipo formal.

    [Arguments]     ${json_massa_testes}    ${expected_message}

    Dado que eu tenha uma nova estrutura administrativa do tipo formal
    Quando eu realizo o cadastro desse estrutura
    Então devo ver a mensagem de sucesso
    E devo ver essa estrutura na lista


***Test Cases***
Nome organograma não informado.    
...     TC02_Orgn_Adm_Formal_Sem_Nome.json                  Nome do Organograma é obrigatório. 

Pesso Jurídica não selecionada, estrutura inicial da árvore.    
...     TC02_Orgn_Adm_Formal_Nv_00_Sem_Pessoa_Juridica.json       Favor informar a Pessoa Jurídica referente a esta Entidade!
    [Documentation]     O campo “Pessoa Jurídica” é obrigatório quando a estrutura a ser cadastrada for a inicial da árvore
 
Pesso Jurídica não selecionada, níveis abaixo.    
...     TC02_Orgn_Adm_Formal_Nv_03_Sem_Pessoa_Juridica.json       Favor informar a Pessoa Jurídica referente a esta instituição!   
    [Documentation]     O campo “Pessoa Jurídica” é obrigatório para os segundos e terceiros níveis 

Data de Início não informado.
...     TC02_Orgn_Adm_Formal_Sem_DtaInicio.json     Campo data de início é de preenchimento obrigatório
    [Documentation]     A “Data de Início” é exigida em todo cadastro de estrutura, caso não seja 
    ...                 cadastrado o sistema apresenta mensagem de erro

Escolher organograma administrativo como informal, sem selecionar um pai.
...     TC02_Orgn_Adm_Informal_Sem_Superior.json    Organograma informal inválido. Informe um nível superior!
    [Documentation]     O organograma informal não pode ser o registro inicial de uma estrutura, 
    ...                 quando um usuário cadastrar um organograma informal sem nível superior o sistema


#O sistema consiste se o organograma superior informado é o mesmo que está sendo alterado, 
#caso seja o sistema apresenta mensagem de erro ‘O Organograma Superior não pode ser igual 
#ao atual! Verifique.’. Assim como o sistema também consiste se a estrutura cadastrada não é 
#filha dela mesmo, apresentando a mensagem de erro ‘O Organograma não pode ser filho do organograma 
#filho dele mesmo! Verifique.’