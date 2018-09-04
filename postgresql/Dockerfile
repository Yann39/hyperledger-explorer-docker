FROM postgres:10.4-alpine

LABEL authors="Yann39, <rockyracer@mailfence.com>"

# environment variables
ENV USERNAME hppoc
ENV PGPASSWORD password
ENV POSTGRES_PASSWORD password

# Get script for database creation/initialization
RUN wget https://raw.githubusercontent.com/hyperledger/blockchain-explorer/master/app/persistence/postgreSQL/db/explorerpg.sql -O /docker-entrypoint-initdb.d/explorerpg.sql
RUN wget https://raw.githubusercontent.com/hyperledger/blockchain-explorer/master/app/persistence/postgreSQL/db/updatepg.sql -O /docker-entrypoint-initdb.d/updatepg.sql