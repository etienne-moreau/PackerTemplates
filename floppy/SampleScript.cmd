@rem Scan the integrity of system files 
@rem (Required after removing the base English language from an image)
sfc.exe /scannow

@rem Check to see if your drivers are digitally signed, and send output to a log file.
md C:\Elekta
C:\Windows\System32\dxdiag /t C:\Elekta\DxDiag-TestLogFiles.txt