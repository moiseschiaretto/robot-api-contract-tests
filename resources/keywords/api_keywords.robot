*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     ../../libraries/AuthToken.py
Library     schema_validator.py
Resource    ../variables.robot

*** Keywords ***
Iniciar Sessao Da API
    [Documentation]    Cria a sessao HTTP reutilizada por toda a suite (Suite Setup)
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}    verify=${True}

Renovar Token De Acesso
    [Documentation]    Faz login e retorna um accessToken valido para uso nos testes autenticados
    ${token}=    Refresh Token    ${BASE_URL}    ${AUTH_USERNAME}    ${AUTH_PASSWORD}
    RETURN    ${token}

Montar Cabecalho De Autenticacao
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    RETURN    ${headers}

Executar GET
    [Arguments]    ${endpoint}    ${headers}=${None}    ${expected_status}=any
    ${response}=    GET On Session    ${SESSION_ALIAS}    ${endpoint}
    ...    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

Executar POST
    [Arguments]    ${endpoint}    ${payload}    ${headers}=${None}    ${expected_status}=any
    ${response}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}
    ...    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

Executar PUT
    [Arguments]    ${endpoint}    ${payload}    ${headers}=${None}    ${expected_status}=any
    ${response}=    PUT On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}
    ...    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

Executar DELETE
    [Arguments]    ${endpoint}    ${headers}=${None}    ${expected_status}=any
    ${response}=    DELETE On Session    ${SESSION_ALIAS}    ${endpoint}
    ...    headers=${headers}    expected_status=${expected_status}
    RETURN    ${response}

Validar Contrato Da Resposta
    [Arguments]    ${response}    ${schema_relative_path}
    [Documentation]    Valida o corpo da resposta contra o JSON Schema informado
    ...    (caminho relativo a ${SCHEMAS_DIR}, ex: auth/POST/200/schema.json)
    ${schema_path}=    Set Variable    ${SCHEMAS_DIR}/${schema_relative_path}
    Validate Response Schema    ${response.json()}    ${schema_path}

Registrar Log De Execucao
    [Arguments]    ${resource}    ${method}    ${status}    ${request_data}    ${response}
    [Documentation]    Grava o log JSON da execucao em logs/<recurso>/<metodo>/<status>/
    Save Execution Log    ${resource}    ${method}    ${status}    ${request_data}
    ...    ${response.status_code}    ${response.json()}    ${LOGS_DIR}

Verificar Status Da Resposta
    [Arguments]    ${response}    ${status_esperado}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}
