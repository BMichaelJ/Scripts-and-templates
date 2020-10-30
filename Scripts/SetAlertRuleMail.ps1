###Needs some attenion on the -ActionGroup

$AppIns = ""
$ResourceGroup = ""
$SubscriptionId = ""
$Location = ""
$MetricName = ""
$ActionGroupName = ""

$action = New-AzAlertRuleEmail -CustomEmail "email@email.com"
$action.SendToServiceOwners = $false

Add-AzMetricAlertRuleV2 -Name "Failure Anomalies - $AppIns" `
-ResourceGroup $ResourceGroup `
-TargetResourceId "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroup/providers/microsoft.insights/components/$AppIns" `
-Operator GreaterThan `
-Threshold 0 `
-WindowSize 01:00:00 `
-Location $Location `
-TimeAggregationOperator Total `
-ActionGroup $ActionGroupName `
-MetricName $MetricName
