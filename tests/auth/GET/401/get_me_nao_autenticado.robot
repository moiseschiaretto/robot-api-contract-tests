*** Settings ***
Documentation    GET /auth/me - 401 (sem token ou token invalido)
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Consultar Usuario Sem Token Deve Retornar 401
    ${response}=    Executar GET    ${ENDPOINT_AUTH_ME}    expected_status=401
    Verificar Status Da Resposta    ${response}    401
    Validar Contrato Da Resposta    ${response}    auth/GET/401/schema.json
    Registrar Log De Execucao    auth    GET    401    ${None}    ${response}

Consultar Usuario Com Token Invalido Deve Retornar 401
    ${headers}=     Montar Cabecalho De Autenticacao    ${TOKEN_INVALIDO}
    ${response}=    Executar GET    ${ENDPOINT_AUTH_ME}    headers=${headers}    expected_status=401
    Verificar Status Da Resposta    ${response}    401
    Validar Contrato Da Resposta    ${response}    auth/GET/401/schema.json
    Registrar Log De Execucao    auth    GET    401    ${headers}    ${response}
