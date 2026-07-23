*** Settings ***
Documentation    GET /users/{id} - 404 (id inexistente)
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Consultar Usuario Inexistente Deve Retornar 404
    ${response}=    Executar GET    ${ENDPOINT_USERS}/999999    expected_status=404
    Verificar Status Da Resposta    ${response}    404
    Validar Contrato Da Resposta    ${response}    users/GET/404/schema.json
    Registrar Log De Execucao    users    GET    404    ${None}    ${response}
