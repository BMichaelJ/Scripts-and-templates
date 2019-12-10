#An instance of Network Watcher in the region you want to troubleshoot a connection.
#Virtual machines to troubleshoot connections with.
#Connection troubleshoot requires that the VM you troubleshoot from has the AzureNetworkWatcherExtension VM extension installed
#The extension is not required on the destination endpoint

#This example checks connectivity between a virtual machine and a remote endpoint. 
#This example requires that you have Network Watcher enabled in the region containing the source VM.


$rgName = "RGNameForVM"
$sourceVMName = "VMName"

$RG = Get-AzResourceGroup -Name $rgName
$VM1 = Get-AzVM -ResourceGroupName $rgName | Where-Object -Property Name -EQ $sourceVMName

$networkWatcher = Get-AzNetworkWatcher | Where-Object -Property Location -EQ -Value $VM1.Location 

Test-AzNetworkWatcherConnectivity -NetworkWatcher $networkWatcher -SourceId $VM1.Id -DestinationAddress "enter DestinationIP" -DestinationPort "enter Port"