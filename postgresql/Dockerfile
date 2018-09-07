FROM postgres:10.4-alpine

LABEL authors="Yann39, <rockyracer@mailfence.com>"

# environment variables
ENV USERNAME hppoc
ENV PGPASSWORD password
ENV POSTGRES_PASSWORD password

# Get argument from compose file
ARG EXPLORER_BRANCH

# Get script for database creation/initialization
RUN wget https://raw.githubusercontent.com/hyperledger/blockchain-explorer/$EXPLORER_BRANCH/app/persistence/postgreSQL/db/explorerpg.sql -O /docker-entrypoint-initdb.d/explorerpg.sql && \
    wget https://raw.githubusercontent.com/hyperledger/blockchain-explorer/$EXPLORER_BRANCH/app/persistence/postgreSQL/db/updatepg.sql -O /docker-entrypoint-initdb.d/updatepg.sql

# Replace :user, :passwd and :dbname variables in the explorerpg.sql script
RUN sed -i 's/:user/hppoc/g' /docker-entrypoint-initdb.d/explorerpg.sql && \
    sed -i "s/:passwd/'password'/g" /docker-entrypoint-initdb.d/explorerpg.sql && \
    sed -i 's/:dbname/fabricexplorer/g' /docker-entrypoint-initdb.d/explorerpg.sql