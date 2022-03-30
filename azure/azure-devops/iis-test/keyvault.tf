locals {
  keyvault_prefix = substr(var.account_name,0,11)
}

resource "azurerm_key_vault" "kv-main" {
    name                            = "${local.keyvault_prefix}-main-dev"
    resource_group_name             = azurerm_resource_group.main.name
    location                        = var.location
    tenant_id = data.azurerm_client_config.current.tenant_id
    #specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault
    enabled_for_deployment          = true
    #specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys
    enabled_for_disk_encryption     = true
    #specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault
    enabled_for_template_deployment = true
    #Sku standard/premium
    sku_name                        = "standard"
    
	# access_policy {
    #     #Azure Active Directory tenant ID, need to be the same GUID as tenant_id
    #     tenant_id = data.azurerm_client_config.current.tenant_id
    #     #The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.
    #     #Azure Backup Service
    #     object_id = data.azuread_service_principal.BackupManagementService.id
    #     key_permissions = [
    #         "get","list","backup"
    #     ]
    #     #Secret permissions set for the service principal account (backup, get, list, recover, restore, set)
    #     secret_permissions = [
    #         "get","list","backup"
    #     ]
    #     #storage_permissions = [
    #     #    ""
    #     #]
    # }
	access_policy {
        #Azure Active Directory tenant ID, need to be the same GUID as tenant_id
        tenant_id = data.azurerm_client_config.current.tenant_id
        #The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault.
        object_id = data.azurerm_client_config.current.object_id
        key_permissions = [ "get","list","create" ]
        #Secret permissions set for the service principal account (backup, get, list, recover, restore, set)
        secret_permissions = [ "backup","get","list","recover","restore","set" ]
    }
 
#Network Access Lists, Security is bypassed for the Azure Services and Azure
#Key Vault is reachable from a remote network based on a IP. Azure Key Vault
#is not reachable from the Internet (Deny)
    network_acls {
        #which traffic can bypass the network rules
        bypass          = "AzureServices"
        #Default action is Deny
        default_action  = "Deny"
        ip_rules        = var.remote_ips
    }
    tags = var.tags
}