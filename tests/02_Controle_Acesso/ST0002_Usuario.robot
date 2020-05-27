*** Settings ***
Documentation         Manutenção de Usuário
...                   Funcionalidade de manutenção de usuários, deve-se ter um usuário e senha válidos 
...                   com acesso ao objeto wmusuario e com as ações liberadas.

Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}      ${SENHA_GLOBAL}
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Test Cases ***
Cenário 01: Criação de um usuário sem ad
    [Tags]              smoke
    [Documentation]     Funcionalidade de inserção de um usuário sem acesso por AD, a partir de um arquivo json
    ...                 todos os passo de inserção e acesso de um novo usuário
    
    Dado que eu tenha um novo usuário       TC01_Usuario_Novo_Sem_AD.json
    BasePage.E acesso a funcionalidade      app.quartzo.wmusuario
    Quando eu realizo o cadastro desse usuário
    Entao devo ver esse usuário na lista
    #E devo conseguir acessar ao sistema

Cenário 02: Criação de um usuário com ad
    [Tags]              smoke  
    [Documentation]     Funcionalidade de inserção de um usuário com acesso por AD, a partir de um arquivo json
    ...                 todos os passo de inserção e acesso de um novo usuário

    Dado que eu tenha um novo usuário       TC01_Usuario_Novo_Com_AD.json
    BasePage.E acesso a funcionalidade      app.quartzo.wmusuario
    Quando eu realizo o cadastro desse usuário
    Entao devo ver esse usuário na lista
    #E devo conseguir acessar ao sistema

Cenário 03: Usuário com CPF inválido
    [Tags]              validacao   
    [Documentation]     Funcionalidade de inserção de um usuário com cpf inválido a partir de um arquivo json
 
    Dado que eu tenha um novo usuário       TC01_Usuario_Novo_CPF_Invaldio.json
    BasePage.E acesso a funcionalidade      app.quartzo.wmusuario
    Quando eu realizo o cadastro desse usuário
    BasePage.E devo ver a mensagem de erro  
    ...     Informe um CPF válido.

Cenário 04: Usuário sem informar nenhum campo
    [Tags]              validacao   
    [Documentation]     Funcionalidade de inserção de um usuário somente clicando no botão Confirmar
 
    Dado que eu não tenha informado nenhum usuário
    BasePage.E acesso a funcionalidade      app.quartzo.wmusuario
    Quando eu realizo o cadastro desse usuário vazio
    BasePage.E devo ver a mensagem de erro  
    ...     Informe um CPF válido.
    BasePage.E devo ver a mensagem de erro  
    ...     Confirme a Senha é obrigatório.
    BasePage.E devo ver a mensagem de erro  
    ...     Senha é obrigatório.
    BasePage.E devo ver a mensagem de erro  
    ...     Login é obrigatório.
    BasePage.E devo ver a mensagem de erro  
    ...     Email é obrigatório.
    BasePage.E devo ver a mensagem de erro  
    ...     Data de Nascimento é obrigatório.
    BasePage.E devo ver a mensagem de erro  
    ...     Nome é obrigatório.
    BasePage.E devo ver a mensagem de erro  
    ...     CPF é obrigatório.
