# get all nics for all vms an lists the NicName, Private IP and Allocationmethod

$nic = (((Get-AZVM).NetworkProfile).NetworkInterfaces).Id
ForEach ($i in $nic) {
  $nicname = $i.substring($i.LastIndexOf("/")+1)
  Get-AzNetworkInterface -Name $nicname | Get-AzNetworkInterfaceIpConfig | select-object  Name,PrivateIpAddress,PrivateIpAllocationMethod
}