@echo off
echo This will grab the latest platform-tools zip from google servers and extract it to your users home directory 
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/android/repository/platform-tools-latest-windows.zip', 'platform-tools-latest-windows.zip')"
powershell -command "Expand-Archive -Force 'platform-tools-latest-windows.zip' '~'"
echo Platform tools has been setup! opening up the directory now...
echo Happy Flashing! :)
powershell -Command "ii $home/platform-tools" 
timeout /t 5
