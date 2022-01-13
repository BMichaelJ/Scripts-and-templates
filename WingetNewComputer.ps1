
#Install New apps
$apps = @(
    @{name = "Microsoft.AzureCLI" }, 
    @{name = "Microsoft.PowerShell" }, 
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "Microsoft.WindowsTerminal" }, 
    @{name = "Microsoft.AzureStorageExplorer" }, 
    @{name = "Microsoft.PowerToys" }, 
    @{name = "Git.Git" }, 
    @{name = "WhatsApp.WhatsApp" },
    @{name = "Microsoft.VisualStudioCode.Insiders" },
    @{name = "Discord.Discord" },
    @{name = "GitHub.cli" },
    @{name = "Spotify.Spotify" },
    @{name = "SlackTechnologies.Slack" },
    @{name = "Microsoft.PowerBI" }
);
Foreach ($app in $apps) {
    #check if the app is already installed
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($app.source -ne $null) {
            winget install --exact --silent $app.name --source $app.source
        }
        else {
            winget install --exact --silent $app.name 
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}
