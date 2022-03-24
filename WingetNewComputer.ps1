# If first run, then msstore needs eula accepeted and done by adding --accept-source-agreements as argument


#Install New apps
$apps = @(
    @{name = "Microsoft.AzureCLI" }, 
    @{name = "Microsoft.PowerShell" }, 
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "Microsoft.WindowsTerminal" },
    @{name = "Docker.DockerDesktop" },
    @{name = "Microsoft.AzureStorageExplorer" },
    @{name = "Microsoft.AzureStorageEmulator" },
    @{name = "Microsoft.Bicep" },
    @{name = "Microsoft.AzureFunctionsCoreTools" },
    @{name = "Microsoft.AzureDataStudio.Insiders" },
    @{name = "Microsoft.AzureCosmosEmulator" },
    @{name = "Microsoft.azure-iot-explorer" }, 
    @{name = "Microsoft.PowerToys" }, 
    @{name = "Git.Git" }, 
    @{name = "WhatsApp.WhatsApp" },
    @{name = "OpenWhisperSystems.Signal" },
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
            winget install --exact --silent $app.name --source $app.source --accept-source-agreements
        }
        else {
            winget install --exact --silent $app.name --accept-source-agreements
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}
