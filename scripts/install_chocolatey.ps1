$env:chocolateyUseWindowsCompression = 'false'
#Invoke-WebRequest -Uri 'https://chocolatey.org/install.ps1' -UseBasicParsing | Invoke-Expression
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
