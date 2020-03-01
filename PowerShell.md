# PowerShell

## Enable script esecution
```PowerShell
Get-ExecutionPolicy                 # Show actual state (restricted/unrestricted)
Set-ExecutionPolicy restricted      # Disallows all Scripts
Set-ExecutionPolicy unrestricted    # Allows all Scripts
# List All profiles
Get-ExecutionPolicy -List | Format-Table -AutoSize
```
