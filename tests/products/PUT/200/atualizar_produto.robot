*** Settings ***
Documentation    PUT /products/{id} - 200
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Atualizar Produto Deve Retornar 200
    ${payload}=    Create Dictionary    title=Produto Atualizado Via Robot Framework
    ${response}=    Executar PUT    ${ENDPOINT_PRODUCTS}/1    ${payload}    expected_status=200
    Verificar Status Da Resposta    ${response}    200
    Validar Contrato Da Resposta    ${response}    products/PUT/200/schema.json
    Registrar Log De Execucao    products    PUT    200    ${payload}    ${response}
