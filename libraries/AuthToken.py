"""
AuthToken.py

Biblioteca Python usada como Suite Setup para renovar o token de acesso
da API DummyJSON antes da execução dos testes - equivalente ao fluxo
`test:refresh-token` do projeto de referência (playwright-public-api-contract-tests).

O token obtido é gravado em um arquivo de cache (.token-cache.json) e também
retornado para ser usado como variável de suíte (${ACCESS_TOKEN}).
"""

import json
import os
import requests


CACHE_FILE = os.path.join(os.path.dirname(__file__), "..", ".token-cache.json")


def refresh_token(base_url, username, password):
    """
    Faz login na API e retorna um token de acesso válido.

    Uso no Robot Framework:
        ${token}=    Refresh Token    ${BASE_URL}    ${AUTH_USERNAME}    ${AUTH_PASSWORD}
    """
    url = f"{base_url}/auth/login"
    payload = {
        "username": username,
        "password": password,
        "expiresInMins": 60,
    }

    response = requests.post(url, json=payload, timeout=15)
    response.raise_for_status()

    data = response.json()
    token = data.get("accessToken") or data.get("token")

    if not token:
        raise RuntimeError(
            "Nao foi possivel obter o accessToken na resposta de /auth/login: "
            f"{data}"
        )

    _save_token_cache(token)
    return token


def _save_token_cache(token):
    cache_path = os.path.abspath(CACHE_FILE)
    with open(cache_path, "w", encoding="utf-8") as f:
        json.dump({"accessToken": token}, f)


def load_cached_token():
    """
    Retorna o token salvo em cache, ou string vazia se nao existir.
    Util para reaproveitar o token entre execucoes sem logar de novo.
    """
    cache_path = os.path.abspath(CACHE_FILE)
    if os.path.exists(cache_path):
        try:
            with open(cache_path, "r", encoding="utf-8") as f:
                return json.load(f).get("accessToken", "")
        except (json.JSONDecodeError, OSError):
            return ""
    return ""
