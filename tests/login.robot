***Settings***
Documentation   Login
...             Sendo um administrador de catálogo
...             Quero me autenticar no sistema
...             Para que eu possa gerenciar os produtos da loja virtual

Resource        ../resources/actions.robot

Suite Setup         Open Session
Suite Teardown      Close Session
Test Teardown       End Test

***Test Cases***
Usuário autenticado
    [tags]     success_login
    Dado que acesso a página login
    Quando submeto minhas credenciais "papito@ninjapixel.com" e "pwd123"
    Então devo ser autenticado

    [Teardown]      Clear Local Storage

Senha invalida
    [Template]          Tentativa de login
    papito@ninjapixel.com       abc123      Usuário e/ou senha inválidos

# Desafio: implementar Test Template para o comportamento de tentativa de login
# para os demais cenários:

# Entrega, na seção de comentarios da Aula.
# Valendo o Performance Tests na faixa para os 5 primeiros a partir das 15h do dia 13 de maio.

Email não cadastrado
    Dado que acesso a página login
    Quando submeto minhas credenciais "404@ninjapixel.com" e "abc123"
    Então devo ver a mensagem de alerta "Usuário e/ou senha inválidos"

Email incorreto
    Dado que acesso a página login
    Quando submeto minhas credenciais "joao&gmail.com" e "abc123"
    Então devo ver a mensagem de alerta "Usuário e/ou senha inválidos"

Email não informado
    Dado que acesso a página login
    Quando submeto minhas credenciais "${EMPTY}" e "abc123"
    Então devo ver a mensagem de alerta "Opps. Informe o seu email!"

Senha não informada
    Dado que acesso a página login
    Quando submeto minhas credenciais "papito@ninjapixel.com" e "${EMPTY}"
    Então devo ver a mensagem de alerta "Opps. Informe a sua senha!"

***Keywords***
Tentativa de login
    [Arguments]         ${input_email}      ${input_pass}       ${output_text}

    Dado que acesso a página login
    Quando submeto minhas credenciais "${input_email}" e "${input_pass}"
    Então devo ver a mensagem de alerta "${output_text}"