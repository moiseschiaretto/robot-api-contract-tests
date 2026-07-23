*** Settings ***
Documentation    POST /auth/login - 400 (credenciais invalidas)
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Login Com Senha Incorreta Deve Retornar 400
    ${payload}=    Create Dictionary    username=${AUTH_USERNAME}    password=senha-errada-de-proposito
    ${response}=    Executar POST    ${ENDPOINT_AUTH_LOGIN}    ${payload}    expected_status=400
    Verificar Status Da Resposta    ${response}    400
    Validar Contrato Da Resposta    ${response}    auth/POST/400/schema.json
    Registrar Log De Execucao    auth    POST    400    ${payload}    ${response}
