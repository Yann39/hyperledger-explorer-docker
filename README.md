# Windows 10 64 bits Hyperledger Explorer setup

![Hyperledger Explorer logo](hyperledger-explorer-logo.png?raw=true "Hyperledger Explorer")

## Prerequisites

A running **Hyperledger Fabric** network.

I used Hyperledger Fabric **v1.2**.
See [Hyperledger Fabric documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.2/).

I included the configuration for an example network (_app/config/configtx.yaml_ and _app/config/crypto-config.yaml_ files).

Also don't forget to configure **Git** for Windows :

Check _autocrlf_ :

```bash
git config --get core.autocrlf
```

if `null` or `true`, set it to `false` :

```bash
git config --global core.autocrlf false
```

Check _longpaths_ :

```bash
git config --get core.longpaths
```

if `null` or `false`, set it to `true` :

```bash
git config --global core.longpaths true
```

## Cleaning

In case you already set up the environment, here are some useful cleanup commands

1. Clean all containers containing "blockchain-explorer" in their name

```bash
docker stop $(docker ps -a --filter="name=blockchain-explorer")
docker rm $(docker ps -a --filter="name=blockchain-explorer")
```

2. Clean all images with name starting with "hyperledger-blockchain-explorer" or "dev-peer"

```bash
docker rmi $(docker images hyperledger-blockchain-explorer* -q)
```

3. Prune networks and volumes

```bash
docker network prune
docker volume prune
```

4. Remove crypto materials

```bash
rm -rf app/config/crypto-config/
```

## The network

The **Hyperledger network** in which I ran this example is composed of :
- 2 organizations :
  * myorg1
  * myorg2
- 2 peers per organization :
  * myorg1 : peer0.myorg1.ch and peer1.myorg1.ch
  * myorg2 : peer0.myorg2.ch and peer1.myorg2.ch
- peer0 from both organizations have been defined as anchor peer
- all peers use _CouchDB_ as ledger state database
- 1 user (identity) per peer (in addition to _Admin_ user)
- 1 orderer (use its own channel _orderer-channel_) with _kafka_ consensus
- 1 channel _my-channel_ joined by both peer0 from both organizations
- 1 Go chaincode
- 4 Kafka nodes and 3 Zookeeper (as recommended)

See _app/config/configtx.yaml_ and _app/config/crypto-config.yaml_ for example configuration and [Hyperledger Fabric documentation](https://hyperledger-fabric.readthedocs.io/en/release-1.2/) for the setup.

## Usage

I have build a **custom setup**, that I think is simpler than the mentioned steps (from the [official repository](https://github.com/hyperledger/blockchain-explorer) _readme_ file) which consist of downloading the whole repository and then modify the files.

Instead of downloading the repository locally and doing the modification in the sources,
I get the repository directly into a **Docker** container and then link local configuration files to it using volumes.

I have implemented a **Compose** file (_docker-compose.yaml_) that builds the images/containers for the application and the database.
The containers will be attached to the existing Docker network of our Fabric network.

:warning: Make sure you use the same Docker network as your existing Hyperledger Fabric network in the _docker-compose.yaml_ file. Mine is `config_mynw`.

The Application will attach to the database once it is ready (I used a `wait.sh` script to wait for the database to be up).

So all that you need is in the _config_ directory :
1. _config.json_ : file representing the network configuration
2. _crypto-config_ : folder containing the network certificates

You can regenerate the cryptographic materials from the _app/config/configtx.yaml_ and _app/config/crypto-config.yaml_ files if needed.

Then simply run :

```bash
docker-compose up
```

This will run 2 containers :
- `hyperledger_explorer_app` : the application
- `hyperledger_explorer_postgresql` : the database

You should be able to reach http://localhost:8092

For **Swagger** API endpoint, go to http://localhost:8092/api-docs/

## PostGreSQL database

If you need to enter the **PostGreSQL** database manually, here are some useful commands :

Get into the container :

```bash
winpty docker exec -it hyperledger_explorer_postgresql sh
```

Connect to PostGreSQL as postgres user :

```bash
su postgres
psql
```

or :

```bash
psql -U postgres
```

List all databases :

```bash
\list
```

Connect to the `fabricexplorer` database :

```bash
\connect fabricexplorer
```

Select data :

```bash
select * from peer;
```

Quit :

```bash
\q
```

## License

For Hyperledger Explorer, see [LICENSE](https://github.com/hyperledger/blockchain-explorer/blob/master/LICENSE).

Regarding the code I wrote, please refer to the [WTFPL](http://www.wtfpl.net/) license :)