function BaseSoftware-Install ()
{
    Write-Host "$PSScriptRoot"
    $PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    Write-Host "$PSScriptRoot"
    # $ini = Get-IniContent "$autoconf_script_dir\install_base_software.ini"
    # Write-Host $ini
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

BaseSoftware-Install
