*** Settings ***
Documentation    POST /auth/login - 200 (credenciais validas)
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Login Com Credenciais Validas Deve Retornar 200 E Token
    ${payload}=    Create Dictionary    username=${AUTH_USERNAME}    password=${AUTH_PASSWORD}    expiresInMins=${60}
    ${response}=    Executar POST    ${ENDPOINT_AUTH_LOGIN}    ${payload}    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    auth/POST/200/schema.json
    Registrar Log De Execucao    auth    POST    200    ${payload}    ${response}
