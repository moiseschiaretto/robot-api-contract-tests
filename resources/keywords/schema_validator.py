"""
schema_validator.py

Biblioteca Python para validacao de contrato de resposta de API via JSON Schema
(equivalente direto ao Joi usado no projeto de referencia em Playwright/Node).

Tambem grava um log JSON por execucao em logs/<recurso>/<metodo>/<status>/,
replicando o padrao ja usado no restante do portfolio.
"""

import json
import os
from datetime import datetime, timezone

from jsonschema import Draft7Validator


def validate_response_schema(response_body, schema_path):
    """
    Valida o corpo de uma resposta HTTP (dict ou lista) contra um JSON Schema.

    Uso no Robot Framework:
        Validate Response Schema    ${response.json()}    ${SCHEMAS_DIR}/auth/POST/200/schema.json

    Lanca AssertionError com a lista de erros se a validacao falhar.
    """
    schema_path = os.path.abspath(schema_path)

    if not os.path.exists(schema_path):
        raise FileNotFoundError(f"Schema nao encontrado: {schema_path}")

    with open(schema_path, "r", encoding="utf-8") as f:
        schema = json.load(f)

    validator = Draft7Validator(schema)
    errors = sorted(validator.iter_errors(response_body), key=lambda e: e.path)

    if errors:
        mensagens = [f"- {list(e.path)}: {e.message}" for e in errors]
        raise AssertionError(
            "Falha na validacao de contrato (schema):\n" + "\n".join(mensagens)
        )

    return True


def save_execution_log(resource, method, status, request_data, response_status, response_body, logs_dir):
    """
    Grava um arquivo .json de log por execucao, no padrao:
    logs/<recurso>/<metodo>/<status>/<timestamp>.json

    Uso no Robot Framework:
        Save Execution Log    auth    POST    200    ${payload}    ${response.status_code}
        ...    ${response.json()}    ${LOGS_DIR}
    """
    target_dir = os.path.join(os.path.abspath(logs_dir), resource, method, str(status))
    os.makedirs(target_dir, exist_ok=True)

    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    log_path = os.path.join(target_dir, f"{timestamp}.json")

    log_entry = {
        "timestamp": timestamp,
        "resource": resource,
        "method": method,
        "expected_status": status,
        "request": request_data,
        "response_status": response_status,
        "response_body": response_body,
    }

    with open(log_path, "w", encoding="utf-8") as f:
        json.dump(log_entry, f, indent=2, ensure_ascii=False, default=str)

    return log_path
