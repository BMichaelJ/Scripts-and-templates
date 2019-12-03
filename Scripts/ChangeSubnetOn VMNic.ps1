# VM Info, have added VMName1 and 2 if needed to extend additionally#

$RGName = "RGName for the VM(s) that you are to change the Nic for"
$VMName1 = "VMNameVM1"
$VMName2 = "VMNameVM1"

#$VirtualMachine1 = Get-azVM -ResourceGroupName $RGname -Name $VMName1
#$VirtualMachine2 = Get-azVM -ResourceGroupName $RGname -Name $VMName2

# Have the Nicmane, Subnetname, and Vnet info

$NicVM1 = "The NicName on VM1"
$NicVM2 = "the NicName on VM2"

$NIC1 = Get-azNetworkInterface -Name $NicVM1 -ResourceGroupName $RGName
$NIC2 = Get-azNetworkInterface -Name $NicVM2 -ResourceGroupName $RGName

$NIC1.IpConfigurations[0].PrivateIpAddress
$NIC2.IpConfigurations[0].PrivateIpAddress

$VNETname = "The VNetName"
$SubnetTOname = "Subnet TO Where the Nic is to be moved"

$VNET = Get-azVirtualNetwork -Name $VNETname  -ResourceGroupName $RGName

$Subnet2 = Get-azVirtualNetworkSubnetConfig -VirtualNetwork $VNET -Name $SubnetTOname


##Switch subnet on nic
$NIC1.IpConfigurations[0].Subnet.Id = $Subnet2.Id
$NIC2.IpConfigurations[0].Subnet.Id = $Subnet2.Id

Set-azNetworkInterface -NetworkInterface $NIC1
Set-azNetworkInterface -NetworkInterface $NIC2

#Verify subnetSwitch
$NIC1 = Get-azNetworkInterface -Name $NicVM1 -ResourceGroupName $RGname
$NIC2 = Get-azNetworkInterface -Name $NicVM2 -ResourceGroupName $RGname

$NIC1.IpConfigurations[0].PrivateIpAddress
$NIC2.IpConfigurations[0].PrivateIpAddress