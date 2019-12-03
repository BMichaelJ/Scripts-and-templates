function Get-ARMVM
{
  $RGs = Get-AzResourceGroup
  foreach($RG in $RGs)
  {
    $VMs = Get-AzVM -ResourceGroupName $RG.ResourceGroupName
    foreach($VM in $VMs)
    {
      $VMDetail = Get-AzVM -ResourceGroupName $RG.ResourceGroupName -Name $VM.Name -Status
      $RGN = $VMDetail.ResourceGroupName  
      foreach ($VMStatus in $VMDetail.Statuses)
      { 
          $VMStatusDetail = $VMStatus.DisplayStatus
      }
      Write-Output "Resource Group: $RGN", ("VM Name: " + $VM.Name), "Status: $VMStatusDetail" `n
    }
  }
}