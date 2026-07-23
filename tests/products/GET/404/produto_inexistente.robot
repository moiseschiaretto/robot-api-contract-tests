*** Settings ***
Documentation    GET /products/{id} - 404 (id inexistente)
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Consultar Produto Inexistente Deve Retornar 404
    ${response}=    Executar GET    ${ENDPOINT_PRODUCTS}/999999    expected_status=404
    Verificar Status Da Resposta    ${response}    404
    Validar Contrato Da Resposta    ${response}    products/GET/404/schema.json
    Registrar Log De Execucao    products    GET    404    ${None}    ${response}
