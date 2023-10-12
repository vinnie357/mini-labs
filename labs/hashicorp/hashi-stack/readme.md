# mini hashi-stack in docker-compose

has nomad, consul, vault

## tools
docker
docker-compose

## setup

```
export vault_token="mytoken"
# with logs
docker-compose up

#without logs
docker-compose up -d

# delete disks
docker-compose down --volumes
```

## connect

consul = localhost:8500
nomad = localhost:4646
vault = localhost:8200

