targetScope = 'subscription'

// If an environment is set up (dev, test, prod...), it is used in the application name
param environment string = 'dev'
param applicationName string = 'demo-logicapp-0127'
param location string = 'northeurope'
var instanceNumber = '001'

var defaultTags = {
  'environment': environment
  'application': applicationName
  'nubesgen-version': '0.7.1-SNAPSHOT'
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${applicationName}-${instanceNumber}'
  location: location
  tags: defaultTags
}

var applicationEnvironmentVariables = [
// You can add your custom environment variables here      
]

module function 'modules/logicapp/logicapp.bicep' = {
  name: 'logicapp'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    applicationName: applicationName
    environment: environment
    resourceTags: defaultTags
    instanceNumber: instanceNumber
    environmentVariables: applicationEnvironmentVariables
  }
}
