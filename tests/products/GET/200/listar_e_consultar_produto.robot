*** Settings ***
Documentation    GET /products e GET /products/{id} - 200
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Listar Produtos Deve Retornar 200
    ${response}=    Executar GET    ${ENDPOINT_PRODUCTS}    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    products/GET/200/schema_list.json
    Registrar Log De Execucao    products    GET    200    ${None}    ${response}

Consultar Produto Por Id Deve Retornar 200
    ${response}=    Executar GET    ${ENDPOINT_PRODUCTS}/1    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    products/GET/200/schema_single.json
    Registrar Log De Execucao    products    GET    200    ${None}    ${response}
