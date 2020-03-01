function BaseSoftware-Install ()
{
    Clear-Host
    Write-Host "[BASE-SOFTWARE] working path: $PSScriptRoot"
    Write-Host "[BASE-SOFTWARE] using temp folder: $env:TEMP"
    $autoconf_script_dir = $PSScriptRoot
    $sys_temp = $env:TEMP
    $ini = Get-IniContent "$autoconf_script_dir\install_base_software.ini"

    $src_url_key = 'src_url'
    $dst_name_key = 'dst_name'
    $cmd_key = 'cmd'
    
    #Write-Host "[BASE-SOFTWARE] $ini.Keys"
    
    # $ini | Format-Table

    Foreach ($section_key in $ini.Keys)
    {
        if ($section_key -ne "No-Section"){
            Write-Host "[BASE-SOFTWARE] Installing $section_key"
            $section = $ini[$section_key]
            #$section | Format-Table
            $src_url = $section[$src_url_key]
            $dst_name = $section[$dst_name_key]
            $cmd = $section[$cmd_key]
            $inst_file = "$sys_temp\$dst_name"
            Get-FileFromUrl $src_url $inst_file
            Write-Host "[BASE-SOFTWARE] Starting $section_key installer"
            Invoke-Expression $cmd
            Write-Host "[BASE-SOFTWARE] $section_key installed"
            Start-Sleep -s 5
            Remove-Item $inst_file -Force
        }
    }
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
    Write-Host "[BASE-SOFTWARE] Downloading: [$src_url] to: [$dst_filePath]"

    if (Get-Command 'Invoke-Webrequest')
    {
         $ret = Invoke-WebRequest -URI $src_url -OutFile $dst_filePath
    }
    else
    {
        $WebClient = New-Object System.Net.WebClient
        $ret = $webclient.DownloadFile($src_url, $dst_filePath)
    }
    Write-Host "[BASE-SOFTWARE] Download COMPLETED !!!"
    return $ret
}

BaseSoftware-Install
