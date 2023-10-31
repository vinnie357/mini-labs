# (radius)[https://radapp.io/]

no not (RFC2865)[https://datatracker.ietf.org/doc/html/rfc2865] 

## requirements

    - docker
    - vscode extension	`ms-azuretools.rad-vscode-bicep`
        this is temporary until bicep supports radius directly.
    - running k8s cluster
        going to use our kind example

## (install)[https://docs.radapp.io/installation/]

`note this also installs rad-cli and bicep`

```bash
. scripts/docker.sh
. scripts/kind.sh
. scripts/rad-cli.sh

```


## setup

```bash
kind create cluster
# make sure you have the right cluster config
kubectl config current-context
# start a rad env
rad init
# check deployment status
kubectl get deployments -n radius-system
# check items
rad env list
# show all things created in radius-system
kubectl -n radius-system get all
```

## (hello-world app)[https://docs.radapp.io/tutorials/new-app/]

### base app deployment

```bash
# check out the service created for you
rad app show radius -o json
# see what is running
rad app connections
# check out the deployment definition
cat app.bicep
# deploy the given configuration
rad deploy app.bicep
# recheck the running items
rad app connections
# build and run?
rad run app.bicep
# curl
curl http://localhost:3000/
```

### add a database

```bash
cat app.bicep

```

append the mongo defintion to the existing app.bicep

```bicep
@description('The ID of your Radius Environment. Set automatically by the rad CLI.')
param environment string

resource mongodb 'Applications.Datastores/mongoDatabases@2023-10-01-preview' = {
  name: 'mongodb'
  properties: {
    environment: environment
    application: application
  }
}
```

preview the `recipe` being used

```bash
rad recipe show default --resource-type Applications.Datastores/mongoDatabases
```

add a connection between the application and the database
```bash
cat app.bicep
```

```bicep
resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'radius.azurecr.io/samples/demo:latest'
      env: {
        FOO: 'bar'
      }
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      mongodb: {
        source: mongodb.id
      }
    }
  }
}
```

re run the application with the new settings

```bash
rad run app.bicep

curl http://localhost:3000/

# view the new connections
rad app connections
```

add a backend service

```bash
cat app.bicep
```

define the new service and its connection
```bicep
resource backend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'backend'
  properties: {
    application: application
    container: {
      image: 'nginx:latest'
      ports: {
        api: {
          containerPort: 80
        }
      }
    }
  }
}

resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'radius.azurecr.io/samples/demo:latest'
      env: {
        FOO: 'bar'
      }
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      mongodb: {
        source: mongodb.id
      }
      backend: {
        source: 'http://backend:80'
      }
    }
  }
}
```

re run the application

```bash
rad run app.bicep
curl http://localhost:3000/
rad app connections
```

### add a gateway

```bash
cat app.bicep
```

append the gateway definition

```bicep
resource gateway 'Applications.Core/gateways@2023-10-01-preview' = {
  name: 'gateway'
  properties: {
    application: application
    routes: [
      {
        path: '/'
        destination: 'http://demo:3000'
      }
    ]
  }
}
```

```bicep
import radius as radius
param application string

resource demo 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'demo'
  properties: {
    application: application
    container: {
      image: 'ghcr.io/radius-project/tutorial/webapp:edge'
      ports: {
        web: {
          containerPort: 3000
        }
      }
    }
    connections: {
      mongodb: {
        source: mongodb.id
      }
      backend: {
        source: 'http://backend:80'
      }
    }
  }
}

@description('The ID of your Radius Environment. Set automatically by the rad CLI.')
param environment string

resource mongodb 'Applications.Datastores/mongoDatabases@2023-10-01-preview' = {
  name: 'mongodb'
  properties: {
    environment: environment
    application: application
  }
}

resource backend 'Applications.Core/containers@2023-10-01-preview' = {
  name: 'backend'
  properties: {
    application: application
    container: {
      image: 'nginx:latest'
      ports: {
        api: {
          containerPort: 80
        }
      }
    }
  }
}

resource gateway 'Applications.Core/gateways@2023-10-01-preview' = {
  name: 'gateway'
  properties: {
    application: application
    routes: [
      {
        path: '/'
        destination: 'http://demo:3000'
      }
    ]
  }
}
```

re run the application

```bash
rad run app.bicep
curl http://localhost:3000/
rad app connections
rad resource list gateways
```


## cleanup

```bash
rm app.bicep
rm -r .rad
kind delete cluster

```