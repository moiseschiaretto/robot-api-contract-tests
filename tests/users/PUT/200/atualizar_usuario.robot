*** Settings ***
Documentation    PUT /users/{id} - 200
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Atualizar Usuario Deve Retornar 200
    ${payload}=    Create Dictionary    firstName=MoisesAtualizado
    ${response}=    Executar PUT    ${ENDPOINT_USERS}/1    ${payload}    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    users/PUT/200/schema.json
    Registrar Log De Execucao    users    PUT    200    ${payload}    ${response}
