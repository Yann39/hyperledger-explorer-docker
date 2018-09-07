FROM node:8.11.3-alpine

LABEL authors="Yann39, <rockyracer@mailfence.com>"

# environment variables
ENV DATABASE_HOST postgresql
ENV DATABASE_PORT 5432
ENV DATABASE_NAME fabricexplorer
ENV DATABASE_USERNAME hppoc
ENV DATABASE_PASSWD password

# Get argument from compose file
ARG EXPLORER_BRANCH

# install required dependencies : python, make, g++, git
RUN apk add --no-cache --virtual npm-deps python make g++ git && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
	rm -r /root/.cache

# install locate from findutils
RUN apk add --no-cache findutils

# install yarn and set permissions
RUN npm install -g yarn && \
    chmod 777 /usr/local/bin/yarn

# get sources (only specified branch and last revision)
RUN git clone --single-branch -b $EXPLORER_BRANCH --depth 1 https://github.com/hyperledger/blockchain-explorer /opt/explorer

# install NPM dependencies
RUN cd /opt/explorer && npm install && npm build

# copy local files to container
COPY ./wait.sh /tmp/wait.sh

# build explorer app
RUN cd /opt/explorer && cd client && npm install && yarn build

# remove installed packages to free space
RUN apk del npm-deps