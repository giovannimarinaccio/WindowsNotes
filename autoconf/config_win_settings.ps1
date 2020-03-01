
function Config-WinSettings (){
    
    setUAC $false
    turnOffMicrosoftConsumerExperience 
    setDesktopIcons $true $false $false $false $true
    setExplorerFilesPrefs $true $false $false
    removeWinBloatware
}

function setExplorerFilesPrefs (
    $ShowFileExtensions,
    $ShowHiddenFiles,
    $ShowSuperHidden){

    Write-Host "[WINSETTINGS] Configuring Eplorer's file preferences ..."

    if ($ShowFileExtensions -eq $true ){ $FileExtensions = 0 } else {  $FileExtensions = 1 }
    if ($ShowHiddenFiles -eq $true ){ $HiddenFiles = 1 } else {  $HiddenFiles = 0 }
    if ($ShowSuperHidden -eq $true ){ $SuperHidden = 1 } else {  $SuperHidden = 0 }
    
    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . HideFileExt $FileExtensions
    Pop-Location

    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . Hidden $HiddenFiles
    Pop-Location

    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . ShowSuperHidden $SuperHidden
    Pop-Location

    Stop-Process -processName: Explorer -force # This will restart the Explorer service to make this work.

    Write-Host "[WINSETTINGS] Eplorer's file preferences CONFIGURED"
}

function setDesktopIcons (
    $This_PC_visible,
    $Users_Files_visible,
    $Control_Panel_visible,
    $Network_visible,
    $Recycle_Bin_visible){

    Write-Host "[WINSETTINGS] Configuring Desktop ICONS visibility ..."

    if ($This_PC_visible -eq $true ){ $This_PC = 0 } else {  $This_PC = 1 }
    if ($Users_Files_visible -eq $true ){ $Users_Files = 0 } else {  $Users_Files = 1 }
    if ($Control_Panel_visible -eq $true ){ $Control_Panel = 0 } else {  $Control_Panel = 1 }
    if ($Network_visible -eq $true ){ $Network = 0 } else {  $Network = 1 }
    if ($Recycle_Bin_visible -eq $true ){ $Recycle_Bin = 0 } else {  $Recycle_Bin = 1 }

    # This_PC
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Value $This_PC -PropertyType DWord -Force -ea SilentlyContinue;
    
    # Users_Files
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -force -ea SilentlyContinue };
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Value $Users_Files -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Value $Users_Files -PropertyType DWord -Force -ea SilentlyContinue;

    #Control_Panel
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -force -ea SilentlyContinue };
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Value $Control_Panel -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}' -Value $Control_Panel -PropertyType DWord -Force -ea SilentlyContinue;

    # Network
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -force -ea SilentlyContinue };
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Value $Network -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}' -Value $Network -PropertyType DWord -Force -ea SilentlyContinue;

    # Recycle_Bin
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -force -ea SilentlyContinue };
    if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Value $Recycle_Bin -PropertyType DWord -Force -ea SilentlyContinue;
    New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{645FF040-5081-101B-9F08-00AA002F954E}' -Value $Recycle_Bin -PropertyType DWord -Force -ea SilentlyContinue;
    
    Write-Host "[WINSETTINGS] Desktop ICONS visibility CONFIGURED"
}


function turnOffMicrosoftConsumerExperience (){
    if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent") -ne $true) {  New-Item "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -force -ea SilentlyContinue };
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableWindowsConsumerFeatures' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
    Write-Host "[WINSETTINGS] Microsoft Consumer Experience turned OFF"
}


function setUAC($enbled){
    $uac_val="0"
    if ($enabled -eq $true ){ $uac_val="1" }
    else{ $uac_val="0" }

    $osversion = (Get-CimInstance Win32_OperatingSystem).Version 
    $version = $osversion.split(".")[0] 
 
    if ($version -eq 10) { 
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value $uac_val 
    } ElseIf ($Version -eq 6) { 
        $sub = $version.split(".")[1] 
        if ($sub -eq 1 -or $sub -eq 0) { 
            Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value $uac_val 
        } Else { 
            Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value $uac_val 
        } 
    } ElseIf ($Version -eq 5) { 
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value $uac_val 
    } Else { 
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value $uac_val 
    }

    if ($enabled -eq $true ){ Write-Host "[WINSETTINGS] UAC turned ON" }
    else{ Write-Host "[WINSETTINGS] UAC turned OFF" }
    
}

function removeWinBloatware(){
    
    Write-Host "[WINSETTINGS] Removing Windows Bloatware ..."
    $packages = @(

        # Default Windows 10 apps
        "Microsoft.3DBuilder",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.Advertising.Xaml",
        "Microsoft.BingFinance",
        "Microsoft.BingFoodAndDrink",
        "Microsoft.BingHealthAndFitness",
        "Microsoft.BingNews",
        "Microsoft.BingSports",
        "Microsoft.BingTranslator",
        "Microsoft.BingTravel",
        "Microsoft.BingWeather",
        "Microsoft.CommsPhone",
        "Microsoft.FreshPaint",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.Messaging",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.MinecraftUWP",
        "Microsoft.MovieMoments",
        "Microsoft.NetworkSpeedTest",
        "Microsoft.Office.OneNote",
        "Microsoft.Office.Sway",
        "Microsoft.OneConnect",
        "Microsoft.People",
        "Microsoft.PPIProjection",
        "Microsoft.Print3D",
        "Microsoft.Reader",
        "Microsoft.RemoteDesktop",
        "Microsoft.SkypeApp",
        "Microsoft.Wallet",
        "Microsoft.Windows.HolographicFirstRun",
        "Microsoft.WindowsAlarms",
        "microsoft.windowscommunicationsapps",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.WindowsMaps",
        "Microsoft.WindowsPhone",
        "Microsoft.WindowsReadingList"
        "Microsoft.WindowsSoundRecorder",
        "Microsoft.Xbox.TCUI",
        "Microsoft.XboxApp",
        "Microsoft.XboxGameCallableUI",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Windows.ContactSupport",
    
        # Apps by Third-Party Publishers
        "26720RandomSaladGamesLLC.*",
        "2FE3CB00.*",
        "34791E63.*",
        "46928bounde.*",
        "4DF9E0F8.*",
        "6Wunderkinder.*",
        "828B5831.*",
        "89006A2E.*",
        "9E2F88E3.*",
        "A278AB0D.*",
        "AccuWeather.*",
        "AD2F1837.*",
        "ActiproSoftwareLLC.*",
        "AdobeSystemsIncorporated.*",
        "AMZNMobileLLC.*",
        "Amazon.com.*",
        "ClearChannelRadioDigital.*",
        "CyberLinkCorp.*",
        "D52A8D61.*",
        "D5EA27B7.*",
        "DB6EA5DB.*",
        "DailymotionSA.*",
        "DolbyLaboratories.*",
        "Drawboard.*",
        "eBayInc.*",
        "Evernote.*",
        "E046963F.*",
        "E0469640.*",
        "Facebook.*",
        "flaregamesGmbH.*",
        "Flipboard.*",
        "GameGeneticsApps.*",
        "GAMELOFTSA.*",
        "GASPMobileGamesInc.*",
        "GoogleInc.*",
        "king.com.*",
        "LenovoCorporation.*",
        "McAfeeInc.*",
        "PandoraMediaInc.*",
        "Playtika.*",
        "ShazamEntertainmentLtd.*",
        "SlingTVLLC.*",
        "SpotifyAB.*",
        "SymantecCorporation.*",
        "TelegraphMediaGroupLtd.*",
        "TheNewYorkTimes.*",
        "TuneIn.*",
        "TripAdvisorLLC.*",
        "Weather.*",
        "Windows.ContactSupport",
        "XeroxCorp.*",
        "YouSendIt.*",
        "ZinioLLC.*"
    )

    ForEach ($packages in $packages) {
        Get-AppxPackage -Name $packages -AllUsers | Remove-AppxPackage -AllUsers

        Get-AppXProvisionedPackage -Online |
        where DisplayName -EQ $packages |
        Remove-AppxProvisionedPackage -Online -AllUsers
    }
    Write-Host "[WINSETTINGS] Windows Bloatware Removed"
}

Config-WinSettings
