
function Config-WinSettings (){
    
    setUAC $false
    turnOffMicrosoftConsumerExperience 
    setDesktopIcons $true $true $false $false $true
    setExplorerFilesPrefs $true $false $false
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

Config-WinSettings
