@setlocal
::fyi, "Directory\Background\shell" path is if you right mouse on the empty *background* of an opened folder
:: and just Directory\shell path would be for right mousing directly on a folder icon

reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\PasteToFile" /f /ve /d "PasteToFile"
reg add "HKEY_CURRENT_USER\Software\Classes\Directory\Background\shell\PasteToFile\command" /f /ve /t REG_EXPAND_SZ /d "\"%%bin%%\elevator.exe\" -hide -c \"pwsh -Command \\""Get-ClipBoard ^> '%%V\newfile.txt'\\""\""

@pause