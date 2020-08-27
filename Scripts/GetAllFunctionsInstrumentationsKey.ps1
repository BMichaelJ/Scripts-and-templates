##Big thanks to Nikolaj for getting me past some hurdles (basically all of them)
#This will list all Functions and APPINSIGHTS_INSTRUMENTATIONKEY +  WEBSITE_CONTENTSHARE (WEBSITE_CONTENTSHARE mostly for easily identify the Function)

$fapps = Get-azfunctionapp
$fapps | foreach { $_ | get-azfunctionappsetting | select -property APP*,WEBSITE_CONTENTSHARE }


#Some additional options
$fapps = Get-azfunctionapp
$fapps | foreach {write-host $_.name ; $_ | get-azfunctionappsetting | select -property APP* -ExpandProperty APP* }