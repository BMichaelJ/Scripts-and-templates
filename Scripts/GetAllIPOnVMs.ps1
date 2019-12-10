
$WorkingDirectory = "C:\Temp\"
if ((Test-Path $WorkingDirectory) -Eq $False) {New-Item -ItemType Directory -Path $WorkingDirectory | Out-Null}
$Date = Get-Date -Format yyyy-MM-dd_HH.mm.ss
$Root = $WorkingDirectory + $Date
$Log = $WorkingDirectory + "-Transcript.txt"
Start-transcript $Log | Out-Null


 
    $Export = $Root + "-AzureIaaS-Export.csv"
    $Report = @()
    $VMs = Get-AzVM
    $INTERFACEs = Get-AzNetworkInterface
  
  
    FOREACH($Server in $INTERFACEs)
    {
    $info = "" | Select VmName, ServerHostName, ResourceGroupName, IpAddress, OSType
    $VM = $VMs | ? -Property Id -eq $Server.VirtualMachine.id
    $info.VMName = $VM.Name
    $info.ServerHostName = $VM.OSProfile.ComputerName
    $info.ResourceGroupName = $VM.ResourceGroupName
    $info.IpAddress = $Server.IpConfigurations | Select-Object -ExpandProperty PrivateIpAddress
    $info.OSType = $VM.StorageProfile.osDisk.osType
    $report+=$info
    }
   
    $Report | Select-Object -Property VMName,ServerHostName,ResourceGroupName,@{Name=’IpAddress’;Expression={[string]::join(“;”, ($_.IpAddress))}},OSType | Export-csv -Path $Export -Append -NoTypeInformation  
 