# NestedDomainJoin

This repo is for quickly deploying a new VM (along with a new VNet and Load Balancer) and automatically configure it as a Domain Controller and create a new forest and domain. Once this base is deployed you have a nested template pair with reference to the deployed Vnet, to test domain joining a VM from ARM template, with credentials for domain joining being secured by Key Vault

Here is a blog series to describe this in more detail
http://azurefabric.com/domain-join-azure-vms-from-arm-template-with-key-vault-secured-credentials-part-1/

# Prerequisites
- Azure Key Vault
- Storage Blob

- 1: Run the template, klick on Deploy to Azure - https://github.com/Azure/azure-quickstart-templates/tree/master/active-directory-new-domain/
- 2: Configure the AD domain with a OU (Cannot be default computers)
- 3: Create and account with least Domain join delegate access.
- 4: Add this accountname and password to Key Vault as secrets
- 5: Fill in the variables in the MainTemplate an LinkedTemplate
- 6: Upload LinkedTemplate.json to a storage blob and retreive the SaS token string
- 7: Run the MainTemplate