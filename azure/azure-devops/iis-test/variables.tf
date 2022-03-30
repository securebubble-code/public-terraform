####################
## Global Variables
####################

variable "account_name"         { description = "The top level account name for the deployment" }
variable "sub_account_name"     { description = "The sub level account name for the deployment (optional)" }
variable "location"             { description = "The location where resources will be created" }
variable "resource_group_name"  { description = "The name of the resource group in which the resources will be created" }
variable "remote_ips"           { description = "Public IPs to lock down access to certain Azure services" }

variable "tags" {
 description = "A map of the tags to use for the resources that are deployed"
 type        = map

 default = {
   name        = "sbubble-test"
   environment = "dev"
 }
}

####################
## Virtual Networks 
####################

variable "vnet01_cidr"          { description = "The CIDR range for the vNet" }
variable "vnet01_external_cidr" { description = "The CIDR range for the External Subnet i.e. devices exposed externally directly" }
variable "vnet01_appgw_cidr"    { description = "The CIDR range for the Application Gateway Subnet i.e. dedicated to the App GW" }
variable "vnet01_internal_cidr" { description = "The CIDR range for the Internal Subnet i.e. devices not exposed externally" }
variable "vnet01_bastion_cidr"  { description = "The CIDR range for the Azure Bastion Subnet" }
variable "vnet01_gateway_cidr"  { description = "The CIDR range for the Azure Gateway Subnet" }

####################
## VM Scale Sets 
####################

variable "admin_user"           { description = "User name to use as the admin account on the VMs" }
variable "http_port"            { description = "Port for HTTP that you want to expose to the external load balancer" }
variable "https_port"           { description = "Port for HTTPS that you want to expose to the external load balancer" }
variable "scaleset_sku"         { description = "SKU to assign the VM Scale set i.e. size of the instances"}

#####################
## Azure DevOps
#####################

variable "organisation"         { description = "Azure DevOps organisation"}
variable "project"              { description = "Azure DevOps project" }
variable "deploymentGroup"      { description = "Name of the deployment group to add server to" }
variable "azuredevops_tag"      { description = "Name of the tag to assign to VMs in the deployment group"}