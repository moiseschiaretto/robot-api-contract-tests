*** Settings ***
Documentation    POST /products/add - 201
Resource         ../../../../resources/keywords/api_keywords.robot
Suite Setup      Iniciar Sessao Da API

*** Test Cases ***
Criar Produto Deve Retornar 201
    ${payload}=    Create Dictionary    title=Produto de Teste Robot Framework
    ${response}=    Executar POST    ${ENDPOINT_PRODUCTS_ADD}    ${payload}    expected_status=201
    Verificar Status Da Resposta    ${response}    201
    Validar Contrato Da Resposta    ${response}    products/POST/201/schema.json
    Registrar Log De Execucao    products    POST    201    ${payload}    ${response}
