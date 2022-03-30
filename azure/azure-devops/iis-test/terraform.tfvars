####################
## Global Variables
####################

account_name        = "sbubble"
sub_account_name    = "test"
location            = "uksouth"
resource_group_name = "securebubble-test"
remote_ips          = [""]
tags                = { environment = "dev" }

####################
## Virtual Networks 
####################

vnet01_cidr             = "10.0.0.0/16"
vnet01_external_cidr    = ["10.0.100.0/24"]
vnet01_appgw_cidr       = ["10.0.101.0/24"]
vnet01_internal_cidr    = ["10.0.102.0/23"]
vnet01_bastion_cidr     = ["10.0.110.0/24"]
vnet01_gateway_cidr     = ["10.0.111.0/24"]

####################
## VM Scale Sets 
####################

admin_user          = "azureadmin"
http_port           = 80
https_port          = 443
scaleset_sku        = "Standard_B2s"

#####################
## Azure DevOps
#####################

organisation        = "securebubble-playground"
project             = "IIS-Test"
deploymentGroup     = "IIS-Servers"
azuredevops_tag     = "app01-deploy"