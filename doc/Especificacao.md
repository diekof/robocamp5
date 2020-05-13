
#   Login
### Sendo um administrador de catálogo, Quero me autenticar no sistema, Para que eu possa gerenciar os produtos da loja virtual

# Caso de Teste
## Usuário autenticado
    Dado que acesso a página login
    Quando eu submeto minhas credenciais "papito@ninjapixel.com" e "pwd123"
    Então devo ser autenticado

## Senha invalida
    Dado que acesso a página login
    Quando submeto minhas credenciais com senha inválida
    Então devo ver a mensagem de alerta "Usuário e/ou senha inválidos"

## Email não cadastrado
    Dado que acesso a página login
    Quando submeto minhas credenciais com email não cadastrado
    Então devo ver a mensagem de alerta "Usuário e/ou senha inválidos"

## Email incorreto
    Dado que acesso a página login
    Quando submeto minhas credenciais com email incorreto
    Então devo ver a mensagem de alerta "Usuário e/ou senha inválidos"

## Email não informado
    Dado que acesso a página login
    Quando submeto minhas credenciais sem o email
    Então devo ver a mensagem de alerta "Opps. Informe o seu email!"

## Senha não informada
    Dado que acesso a página login
    Quando submeto minhas credenciais sem a senha
    Então devo ver a mensagem de alerta "Opps. Informe a sua senha!"