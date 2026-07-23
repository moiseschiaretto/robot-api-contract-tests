*** Settings ***
Documentation    POST /users/add - 201
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Criar Usuario Deve Retornar 201
    ${payload}=    Create Dictionary    firstName=Moises    lastName=Chiaretto    age=${54}
    ${response}=    Executar POST    ${ENDPOINT_USERS_ADD}    ${payload}    expected_status=201
    Verificar Status Da Resposta    ${response}    201
    Validar Contrato Da Resposta    ${response}    users/POST/201/schema.json
    Registrar Log De Execucao    users    POST    201    ${payload}    ${response}
