## AUTOCONF
#
# powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('http://bit.ly/1kEgbuH')"
#

function Autoconf-Main($filePath)
{
    Write-Host "[AUTOCONF] Starting Autoconfig Scripts"

    $win_major_ver = [Environment]::OSVersion.Version.Major

    switch ($win_major_ver) {
       "10"  {Write-Host "[AUTOCONF] Recognized os: Windows 10"; break}
       "7"   {Write-Host "[AUTOCONF] Recognized os: Windows 7"; break}
       default {Write-Host "[AUTOCONF] Unsupported OS" -ForegroundColor Red; exit ; break}
    }

    # Path for the workdir
    $autoconf_dir = "C:\autoconf"
    $scripts_base_url="https://raw.githubusercontent.com/giovannimarinaccio/WindowsNotes/master/autoconf"

    # Check if work directory exists if not create it

    If (Test-Path -Path $autoconf_dir -PathType Container){
        Write-Host "[AUTOCONF] $autoconf_dir already exists" -ForegroundColor Yellow
    } ELSE {
        Write-Host "[AUTOCONF] Creating $autoconf_dir"
        $null = New-Item -Path $autoconf_dir -ItemType directory
    }

    # Check if work directory exists if not create it
    $autoconf_script_dir = "$autoconf_dir\scripts"

    If (Test-Path -Path $autoconf_script_dir -PathType Container){
        Write-Host "[AUTOCONF] Updating script dir: $autoconf_script_dir"
        $null = Remove-Item $autoconf_script_dir -Recurse
        $null = New-Item -Path $autoconf_script_dir -ItemType directory
    } ELSE {
        Write-Host "[AUTOCONF] Creating script dir: $autoconf_script_dir"
        $null = New-Item -Path $autoconf_script_dir -ItemType directory
    }

    Get-FileFromUrl "$scripts_base_url/install_base_software.ini" "$autoconf_script_dir\install_base_software.ini"
    Get-FileFromUrl "$scripts_base_url/install_base_software.ps1" "$autoconf_script_dir\install_base_software.ps1"
    
    # run downloaded scripts
    Invoke-Expression -Command "$autoconf_script_dir\install_base_software.ps1"

    Write-Host "[AUTOCONF] Autoconfig Ended"
}


function Get-IniContent ($filePath)
{
    $ini = @{}
    switch -regex -file $FilePath  
    {  
        "^\[(.+)\]$" # Section  
        {  
            $section = $matches[1]  
            $ini[$section] = @{}  
            $CommentCount = 0  
        }  
        "^(;.*)$" # Comment  
        {  
            if (!($section))  
            {  
                $section = "No-Section"  
                $ini[$section] = @{}  
            }  
            $value = $matches[1]  
            $CommentCount = $CommentCount + 1  
            $name = "Comment" + $CommentCount  
            $ini[$section][$name] = $value  
        }   
        "(.+?)\s*=\s*(.*)" # Key  
        {  
            if (!($section))  
            {  
                $section = "No-Section"  
                $ini[$section] = @{}  
            }  
            $name,$value = $matches[1..2]  
            $ini[$section][$name] = $value  
        }  
    }
    return $ini
}

function Get-FileFromUrl ($src_url, $dst_filePath)
{
    Write-Host "[AUTOCONF] Downloading: [$src_url] to: [$dst_filePath]"

    if (Get-Command 'Invoke-Webrequest')
    {
         $ret = Invoke-WebRequest -URI $src_url -OutFile $dst_filePath
    }
    else
    {
        $WebClient = New-Object System.Net.WebClient
        $ret = $webclient.DownloadFile($src_url, $dst_filePath)
    }
    return $ret
}

Autoconf-Main
