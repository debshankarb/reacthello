@minLength(3)
@maxLength(11)
param storagePrefix string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'

param location string = resourceGroup().location

var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
@description('Specifies the location for resources.')
param location1 string = 'eastus'

resource azbicepasp1 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'azbicep-dev-eus-asp1'
  location: location1
  sku: {
    name: 'S1'
    capacity: 1
  }

}

resource azbicepas 'Microsoft.Web/sites@2022-09-01' = {
  name: 'azbicep-dev-eus-asp1'
  location: location1

  properties:{
    serverFarmId:resourceId('Microsoft.Web/serverfarms' , 'azbicep-dev-eus-asp1')
  }
  dependsOn:[
    azbicepasp1
  ]
}
param location2 string = 'southindia'

resource azbicepasp2 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'azbicep-dev-eus-asp2'
  location: location2
  sku: {
    name: 'S1'
    capacity: 1
  }

}

resource azbicepas2 'Microsoft.Web/sites@2022-09-01' = {
  name: 'azbicep-dev-eus-ap2'
  location: location2
  properties:{
    serverFarmId:resourceId('Microsoft.Web/serverfarms' , 'azbicep-dev-eus-asp1')
  }
  dependsOn:[
    azbicepasp2
  ]
}

output storageEndpoint object = stg.properties.primaryEndpoints
