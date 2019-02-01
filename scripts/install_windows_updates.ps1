$ErrorActionPreference = 'Stop'

$wuInstallExe = Join-Path "$($env:windir)\SYSTEM32" 'WUInstallAMD64.exe'

if (!(Test-Path -Path $wuInstallExe))
{
    #Invoke-WebRequest -UseBasicParsing -Uri 'https://www.dropbox.com/s/bk1dodl4fb7znj3/WUInstallAMD64.exe?dl=1' -OutFile $wuInstallExe
    (New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/s/bk1dodl4fb7znj3/WUInstallAMD64.exe?dl=1', $wuInstallExe)   
}

# See here for details: http://help.wuinstall.com/en/WuInstall.html?RebootShutdownOptions.html

# TRB: wuinstall was failing with 0x80240017 - WU_E_NOT_APPLICABLE - Operation was not performed because there are no applicable updates.)
#      This caused powershell to exit with 11 meaning "at least one error occurred, reboot required"
#      I reran this with /reboot options below and the same problem happened, so I added 11 to 
#      valid_exit_codes in builders/virtualbox/02-win_updates-wmf5.json.

C:\WINDOWS\SYSTEM32\WUInstallAMD64.exe /install /autoaccepteula /silent /nomatch "KB4041685" /reboot_if_needed_force /rebootcycle 10

# These options may be appended to the windows update call above to work around problems related to rebooting or winrm
# /reboot_if_needed_force /rebootcycle 10 /customActionBefore "Powershell.exe Stop-Service -force winrm && Powershell.exe Set-Service -Name winrm -StartupType Disabled" /customActionAfter "Powershell.exe Set-Service -Name winrm -StartupType Automatic && Powershell.exe Start-Service winrm"
