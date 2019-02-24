# Remove Built-in Apps


## List apps
```PowerShell
Get-AppxPackage | Select Name | Sort Name                                  # List of installed apps for current user
Get-AppxProvisionedPackage -Online | Select DisplayName | Sort DisplayName # List of apps installed in system and will be installed for every new user

Remove-AppxPackage -Package $PackageFullName                               # Remove app package for current user (new users will have this app installed)
Remove-AppxPackage -Package $PackageFullName                               # Remove app package for all user (new users will have this app installed)
Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName     # Remove app package from system (new users will not have this app installed)

# System Apps (do not remove)
Get-AppxPackage -PackageTypeFilter Main | ? { $_.SignatureKind -eq "System" } | Sort Name | Format-Table Name, InstallLocation
# Store Apps (Safe to remove)
Get-AppxPackage -PackageTypeFilter Main | ? { $_.SignatureKind -eq "Store" } | Sort Name | Format-Table Name, InstallLocation

# Restore 
Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
```

## Script
save as ps1 and execute:
```PowerShell
# List of AppNames to remove 
$AppsList = "Microsoft.3DBuilder",
"Microsoft.GetHelp",
"Microsoft.Getstarted",
"Microsoft.ConnectivityStore",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.Office.OneNote",
"Microsoft.People",
"Microsoft.SkypeApp",
"Microsoft.StorePurchaseApp",
"Microsoft.WindowsFeedbackHub",
"Microsoft.WindowsMaps",
"Microsoft.XboxApp",
"Microsoft.XboxIdentityProvider",
"Microsoft.BingFinance",
"Microsoft.BingSports",
"Microsoft.FreshPaint",
"Microsoft.Microsoft3DViewer",
"Microsoft.MixedReality.Portal",
"Microsoft.OneConnect",
"Microsoft.Office.OneNote",
"Microsoft.Office.Sway ",
"Microsoft.Print3D",
"Microsoft.ScreenSketch",
"Microsoft.Wallet",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay"
 
ForEach ($App in $AppsList)
{
    $PackageFullName = (Get-AppxPackage $App).PackageFullName
    $ProPackageFullName = (Get-AppxProvisionedPackage -Online | Where {$_.Displayname -eq $App}).PackageName
 
    If ($PackageFullName)
    {
        Write-Host "Removing Package: $App"
        Remove-AppxPackage -Package $PackageFullName
    }
    Else
    {
        Write-Host "Unable To Find Package: $App"
    }
 
    If ($ProPackageFullName)
    {
        Write-Host "Removing Provisioned Package: $ProPackageFullName"
        Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName
    }
    Else
    {
        Write-Host "Unable To Find Provisioned Package: $App"
    }

}
```

## Full list of apps

|DisplayName |App Name & Store Link |v1607 |v1703 |v1709|
|:---------- |:-------------------- |:---- |:---- |:--- |
|Microsoft.3DBuilder |3D Builder |✓ |✓ |†|
|Microsoft.BingWeather |MSN Weather |✓ |✓ |✓|
|Microsoft.DesktopAppInstaller |App Installer |✓ |✓ |✓|
|Microsoft.GetHelp |Get Help |||✓|
|Microsoft.Getstarted |Microsoft Tips |✓ |✓ |✓|
|Microsoft.Messaging |Microsoft Messaging |✓ |✓ |✓|
|Microsoft.Microsoft3DViewer |Mixed Reality Viewer ||✓ |✓|
|Microsoft.MicrosoftOfficeHub |Get Office |✓ |✓ |✓|
|Microsoft.MicrosoftSolitaireCollection |Microsoft Solitaire Collection |✓ |✓ |✓|
|Microsoft.MicrosoftStickyNotes |Microsoft Sticky Notes |✓ |✓ |✓|
|Microsoft.MSPaint |Paint 3D ||✓ |✓|
|Microsoft.Office.OneNote |OneNote |✓ |✓ |✓|
|Microsoft.OneConnect |Paid Wi-Fi & Cellular |✓ |✓ |✓|
|Microsoft.People |Microsoft People |✓ |✓ |✓|
|Microsoft.Print3D |Print 3D |||✓|
|Microsoft.SkypeApp |Skype |✓ |✓ |✓|
|Microsoft.StorePurchaseApp |Store Purchase App1 |✓ |✓ |✓|
|Microsoft.Wallet |Wallet1 ||✓ |✓|
|Microsoft.Windows.Photos |Microsoft Photos |✓ |✓ |✓|
|Microsoft.WindowsAlarms |Windows Alarms & Clock |✓ |✓ |✓|
|Microsoft.WindowsCalculator |Windows Calculator |✓ |✓ |✓|
|Microsoft.WindowsCamera |Windows Camera |✓ |✓ |✓|
|microsoft.windowscommunicationsapps |Mail and Calendar |✓ |✓ |✓|
|Microsoft.WindowsFeedbackHub |Feedback Hub |✓ |✓ |✓|
|Microsoft.WindowsMaps |Windows Maps |✓ |✓ |✓|
|Microsoft.WindowsSoundRecorder |Windows Voice Recorder |✓ |✓ |✓|
|Microsoft.WindowsStore |Windows Store |✓ |✓ |✓|
|Microsoft.Xbox.TCUI |Xbox TCUI |||✓|
|Microsoft.XboxApp |Xbox |✓ |✓ |✓|
|Microsoft.XboxGameOverlay |Xbox Game Bar ||✓ |✓|
|Microsoft.XboxIdentityProvider |Xbox Identity Provider |✓ |✓ |✓|
|Microsoft.XboxSpeechToTextOverlay |Xbox Speech to Text Overlay1 ||✓ |✓|
|Microsoft.ZuneMusic |Groove Music |✓ |✓ |✓|
|Microsoft.ZuneVideo |Movies & TV |✓ |✓ |✓|
