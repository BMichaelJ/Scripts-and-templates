#This script clones an NSG

#name of NSG that you want to copy 
$nsgOrigin = "" 
#name new NSG  
$nsgDestination = "" 
#Resource Group Name of source NSG 
$rgName = "" 
#Resource Group Name when you want the new NSG placed 
$rgNameDest = "DR" 
 
$nsg = Get-azNetworkSecurityGroup -Name $nsgOrigin -ResourceGroupName $rgName 
$nsgRules = Get-azNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg 
$newNsg = Get-azNetworkSecurityGroup -name $nsgDestination -ResourceGroupName $rgNameDest 
foreach ($nsgRule in $nsgRules) { 
    Add-azNetworkSecurityRuleConfig -NetworkSecurityGroup $newNsg ` 
        -Name $nsgRule.Name ` 
        -Protocol $nsgRule.Protocol ` 
        -SourcePortRange $nsgRule.SourcePortRange ` 
        -DestinationPortRange $nsgRule.DestinationPortRange ` 
        -SourceAddressPrefix $nsgRule.SourceAddressPrefix ` 
        -DestinationAddressPrefix $nsgRule.DestinationAddressPrefix ` 
        -Priority $nsgRule.Priority ` 
        -Direction $nsgRule.Direction ` 
        -Access $nsgRule.Access 
} 
Set-azNetworkSecurityGroup -NetworkSecurityGroup $newNsg 