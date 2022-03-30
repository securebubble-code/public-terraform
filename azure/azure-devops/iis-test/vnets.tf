####################
## Virtual Network 1
####################

resource "azurerm_virtual_network" "vnet-01" {
  name                = "vnet-${local.prefix}-01"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  address_space       = [ var.vnet01_cidr ]
  
  tags = var.tags
}

resource "azurerm_subnet" "vnet01-internal" {
    name                 = "${azurerm_virtual_network.vnet-01.name}-internal"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.vnet-01.name
    address_prefixes       = var.vnet01_internal_cidr
    #service_endpoints    = [ "Microsoft.KeyVault","Microsoft.Storage","Microsoft.Sql","Microsoft.Web" ]
}

resource "azurerm_subnet" "vnet01-external" {
    name                 = "${azurerm_virtual_network.vnet-01.name}-external"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.vnet-01.name
    address_prefixes       = var.vnet01_external_cidr
    #service_endpoints    = [ "Microsoft.KeyVault","Microsoft.Storage","Microsoft.Sql","Microsoft.Web" ]
}

# Uncomment to use a subnet dedicated for the Azure application gateway
resource "azurerm_subnet" "vnet01-appgw" {
    name                 = "${azurerm_virtual_network.vnet-01.name}-appgw"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.vnet-01.name
    address_prefixes       = var.vnet01_appgw_cidr
    #service_endpoints    = [ "Microsoft.KeyVault","Microsoft.Storage","Microsoft.Sql","Microsoft.Web" ]
}

resource "azurerm_subnet" "vnet01-bastion" {
    name                 = "AzureBastionSubnet"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.vnet-01.name
    address_prefixes       = var.vnet01_bastion_cidr
}

resource "azurerm_subnet" "vnet01-gateway" {
    name                 = "GatewaySubnet"
    resource_group_name  = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.vnet-01.name
    address_prefixes       = var.vnet01_gateway_cidr
}
