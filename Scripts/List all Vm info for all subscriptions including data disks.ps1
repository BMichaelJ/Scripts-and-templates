#List all Vm info for all subscriptions including data disks (Thanks to @MinhPhung for input on looping throught each subscription)
$vmOutput = @()
$Subs = Get-AzureRmSubscription
Foreach ($Sub in $Subs)
{
Select-AzureRMSubscription $sub | Out-Null
$VMs = Get-AzureRmVM
Foreach ($VM in $VMs)
{
$VMInfo = [PSCustomObject]@{
#"Subscription" = ($VM.ID).substring(0,51)
"ResourceGroup" = $VM.ResourceGroupName
"VM Name" = $VM.Name
"VM Type" = $VM.StorageProfile.osDisk.osType
"VM Profile" = $VM.HardwareProfile.VmSize
"VM OS Disk Size" = $VM.StorageProfile.OsDisk.DiskSizeGB
"VM Data Disk Size" = ($VM.StorageProfile.DataDisks.DiskSizeGB) -join ','
}
$vmOutput += $VMInfo
}
 
}

$vmOutput |ft
#$vmOutput |  export-csv C:\temp\azurevms.csv -delimiter ";" -force -notypeinformation
