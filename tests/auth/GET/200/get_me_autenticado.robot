*** Settings ***
Documentation    GET /auth/me - 200 (token valido)
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Consultar Usuario Autenticado Deve Retornar 200
    ${token}=       Renovar Token De Acesso
    ${headers}=     Montar Cabecalho De Autenticacao    ${token}
    ${response}=    Executar GET    ${ENDPOINT_AUTH_ME}    headers=${headers}    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    auth/GET/200/schema.json
    Registrar Log De Execucao    auth    GET    200    ${headers}    ${response}
