
#Get Vnet and Subnet info, below script only set to list Names and Adresspaces for subnets grouped per Vnet - Export if needed to csv ( $virtual_network_object | Export-Csv #destiation and name)
#Snippet reworked from Azure Inventory Script - https://gallery.technet.microsoft.com/scriptcenter/Azure-Inventory-using-3db0f658

$azureVirtualNetworkDetails = Get-azVirtualNetwork

$virtual_network_object = $null
            $virtual_network_object = @()

            foreach($azureVirtualNetworkDetails_Iterator in $azureVirtualNetworkDetails){
            
            $virtual_network_object_temp = New-Object PSObject


            $virtual_network_object_temp | Add-Member -MemberType NoteProperty -Name "ResourceGroupName" -Value $azureVirtualNetworkDetails_Iterator.ResourceGroupName
            $virtual_network_object_temp | Add-Member -MemberType NoteProperty -Name "Location" -Value $azureVirtualNetworkDetails_Iterator.Location
            $virtual_network_object_temp | Add-Member -MemberType NoteProperty -Name "VNETName" -Value $azureVirtualNetworkDetails_Iterator.Name
            $virtual_network_object_temp | Add-Member -MemberType NoteProperty -Name "AddressSpace" -Value $azureVirtualNetworkDetails_Iterator.AddressSpace.AddressPrefixes
         
            $subnetPerVNET = $azureVirtualNetworkDetails_Iterator.Subnets
            $subnet_count = 1
            foreach($subnetPerVNET_Iterator in $subnetPerVNET) {
                $subnet_name = "Subnet"+$subnet_count
                $subnet_address_space = "SubnetAddressSpace"+$subnet_count
                $virtual_network_object_temp | Add-Member -MemberType NoteProperty -Name $subnet_name -Value $subnetPerVNET_Iterator.Name
                $virtual_network_object_temp | Add-Member -MemberType NoteProperty -Name $subnet_address_space -Value $subnetPerVNET_Iterator.AddressPrefix
                $subnet_count += 1
                
            }
         
            $virtual_network_object += $virtual_network_object_temp
        }

        $virtual_network_object