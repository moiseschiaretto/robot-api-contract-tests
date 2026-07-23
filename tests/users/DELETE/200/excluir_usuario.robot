*** Settings ***
Documentation    DELETE /users/{id} - 200
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Excluir Usuario Deve Retornar 200
    ${response}=    Executar DELETE    ${ENDPOINT_USERS}/1    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    users/DELETE/200/schema.json
    Registrar Log De Execucao    users    DELETE    200    ${None}    ${response}
