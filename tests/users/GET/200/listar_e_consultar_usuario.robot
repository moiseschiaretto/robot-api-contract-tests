*** Settings ***
Documentation    GET /users e GET /users/{id} - 200
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Listar Usuarios Deve Retornar 200
    ${response}=    Executar GET    ${ENDPOINT_USERS}    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    users/GET/200/schema_list.json
    Registrar Log De Execucao    users    GET    200    ${None}    ${response}

Consultar Usuario Por Id Deve Retornar 200
    ${response}=    Executar GET    ${ENDPOINT_USERS}/1    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    users/GET/200/schema_single.json
    Registrar Log De Execucao    users    GET    200    ${None}    ${response}
