param fwname string
param fwipConfigurations array
param fwmanipConfigurations object
param fwapplicationRuleCollections array
param fwnetworkRuleCollections array
param fwnatRuleCollections array
param fwsku string = 'Standard'
param location string = resourceGroup().location
param availabilityZones array

resource firewall 'Microsoft.Network/azureFirewalls@2021-02-01' = {
  name: fwname
  location: location
  zones: !empty(availabilityZones) ? availabilityZones : null
  properties: {
    managementIpConfiguration: fwmanipConfigurations
    ipConfigurations: fwipConfigurations
    applicationRuleCollections: fwapplicationRuleCollections
    networkRuleCollections: fwnetworkRuleCollections
    natRuleCollections: fwnatRuleCollections
    additionalProperties: {
      'Network.DNS.EnableProxy': 'True'
    }
    sku: {
      name: 'AZFW_VNet'
      tier: fwsku
    }
  }
}
output fwPrivateIP string = firewall.properties.ipConfigurations[0].properties.privateIPAddress
output fwName string = firewall.name
