*** Variables ***
# Ambiente
${BASE_URL}                 %{API_BASE_URL=https://dummyjson.com}
${SESSION_ALIAS}            dummyjson

# Credenciais (usuário de demonstração oficial da DummyJSON - docs: https://dummyjson.com/docs/auth)
${AUTH_USERNAME}            %{AUTH_USERNAME=emilys}
${AUTH_PASSWORD}            %{AUTH_PASSWORD=emilyspass}
${TOKEN_INVALIDO}           token-invalido-de-proposito-para-teste-negativo

# Endpoints - auth
${ENDPOINT_AUTH_LOGIN}      /auth/login
${ENDPOINT_AUTH_ME}         /auth/me

# Endpoints - users
${ENDPOINT_USERS}           /users
${ENDPOINT_USERS_ADD}       /users/add

# Endpoints - products
${ENDPOINT_PRODUCTS}        /products
${ENDPOINT_PRODUCTS_ADD}    /products/add

# Diretório raiz de schemas e logs (CURDIR = .../resources, pois este arquivo mora ali)
${SCHEMAS_DIR}              ${CURDIR}/schemas/public-api
${LOGS_DIR}                 ${CURDIR}/../logs
