
#

$subs = Get-AzSubscription

$allResources = @()

foreach ($sub in $subs) 
{
    Select-azSubscription -SubscriptionId $sub.Id
    $resources = Get-azVM
    foreach ($vm in $resources)
    {
        $customPsObject = New-Object -TypeName PsObject
        
        If ($vm.StorageProfile.OsDisk.ManagedDisk.Id -ne $null)
        {
            $osDiskStorageAccount = 'Managed Disk'
        }
        
        else
        {
            $osDiskStorageAccount = ([uri]$vm.StorageProfile.OsDisk.Vhd.Uri).Host
        }
        
        $nics = $vm.NetworkProfile.NetworkInterfaces
        $dataDiskS = $vm.StorageProfile.DataDisks
        $subscription = Get-azSubscription -SubscriptionId ($vm.Id -split '/')[2]
        
        $customPsObject | Add-Member -MemberType NoteProperty -Name VmName -Value $vm.Name
        $customPsObject | Add-Member -MemberType NoteProperty -Name RG -Value $vm.ResourceGroupName
        $customPsObject | Add-Member -MemberType NoteProperty -Name Location -Value $vm.Location
        $customPsObject | Add-Member -MemberType NoteProperty -Name Size -Value $vm.HardwareProfile.VmSize

        $i = 0
        foreach ($adapter in $nics)
        {
            $nic = Get-azResource -ResourceId $adapter.Id
            $vnet = ($nic.Properties.ipConfigurations.properties.subnet -split '/')[-3]
            $subnet = ($nic.Properties.ipConfigurations.properties.subnet -split '/')[-1]
            $privateIpAddress = $nic.Properties.ipConfigurations.properties.privateIPAddress
            $publicIpId = $nic.Properties.ipConfigurations.properties.publicIPAddress.id
            
            if ($publicIpId -eq $null)
            {
                $publicIpAddress = $null
            }
            Else
            {
                $publicIpResource = Get-azResource -ResourceId $publicIpId -ErrorAction SilentlyContinue
                $publicIpAddress = $publicIpResource.Properties.ipAddress
            }
            
            $availabilitySet = ($vm.AvailabilitySetReference.Id -split '/')[-1]        
            $customPsObject | Add-Member -MemberType NoteProperty -Name ("nic-" + $i + "-Vnet") -Value $vnet
            $customPsObject | Add-Member -MemberType NoteProperty -Name ("nic-" + $i + "-Subnet")  -Value $subnet
            $customPsObject | Add-Member -MemberType NoteProperty -Name ("nic-" + $i + "-PrivateIpAddress") -Value $privateIpAddress
            $customPsObject | Add-Member -MemberType NoteProperty -Name ("nic-" + $i + "-PublicIpAddress") -Value $publicIpAddress
            $i++
        }

        $customPsObject | Add-Member -MemberType NoteProperty -Name AvailabilitySet -Value $availabilitySet
        $customPsObject | Add-Member -MemberType NoteProperty -Name osDisk -Value $osDiskStorageAccount

        $i = 0
        foreach ($dataDisk in $dataDiskS)
        {
            if ($DataDisk.ManagedDisk.Id -ne $null)
            {
                $dataDiskHost = 'Managed Disk'
            }
            Else
            {
                $dataDiskHost = ([uri]($dataDisk.Vhd.Uri)).Host
            }
            $customPsObject | Add-Member -MemberType NoteProperty -Name ("dataDisk-" + $i) -Value $dataDiskHost
            $i++
        }
        
        $customPsObject | Add-Member -MemberType NoteProperty -Name Subscription -Value $subscription.Name
        $allResources += $customPsObject
    }
}

$allResources | Export-Csv .\vm-audit.csv -NoTypeInformation