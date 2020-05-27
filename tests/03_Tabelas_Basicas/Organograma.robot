*** Settings ***
Documentation           |   Módulo:     |   Tabelas Básicas                                                                                             |
...                     |   Pacote:     |   Cadastro de Estrutura Organizacional Administrativa e Orçamentária                                          |
...                     |   Objeto:     |   tmorganogramaww?1                                                                                           |
...                     |               |   7.80 -  Permitir visualizar e selecionar as unidades administrativas da estrutura organizacional formal.    |
...                     |               |   1.17 -  Possibilitar a geração ou cadastramento de código da instituição.                                   |
...                     |               |   1.19 -  Possibilitar a tramitação das solicitações de mudanças institucionais.                              |  
...                     |               |   1.20 -  Possibilitar o uso de estrutura de multi-institucional.                                             |
...                     |               |   1.21 -  Possuir tabela de unidades organizacionais com as seguintes características:                        | 
...                     |               |          - Estrutura organizacional (hierarquia)                                                              |        
...                     |               |          - Possibilitar movimentação das áreas na estrutura organizacional                                    |
...                     |               |          - Manter histórico das movimentações                                                                 |
...                     |               |          - Ter relação com a tabela de localidades                                                            |
...                     |               |          - Ter relação com o plano de contas                                                                  |
...                     |               |          - Permitir criar estruturas organizacionais múltiplas (formais e informais).                         |


Resource           ../../resources/actions.robot

Suite Setup         Login Session       ${USUARIO_GLOBAL}   ${SENHA_GLOBAL}
Suite Teardown      Close Session
Test Teardown       Finalizando Teste

*** Test Cases ***
Cenário 01: Estrutura Administrativa Formal
    [Tags]      smoke

    Dado que eu tenha uma nova estrutura administrativa do tipo formal
    ...     TC01_Organograma_Administrativo.json
    Quando eu realizo o cadastro desse estrutura
    hooks.Então devo ver a mensagem de sucesso  
    ...     Registro salvo com sucesso.
    E devo ver essa estrutura na lista