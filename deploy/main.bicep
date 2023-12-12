@description('Specifies the location for resources.')
param location string = 'eastus'

resource azbicepasp1 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-dev-eus-asp1'
  location: location
  sku: {
    name: 'S1'
    capacity: 2
  }
}

resource azbicepas 'Microsoft.Web/sites@2022-09-01' = {
  name: 'azbicep-dev-eus-asp1'
  location: location

  properties:{
    serverFarmId:resourceId('Microsoft.Web/serverfarms' , 'azbicep-dev-eus-asp1')
  }
  dependsOn:[
    azbicepasp1
  ]
}

