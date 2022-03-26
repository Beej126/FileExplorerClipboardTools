setlocal
set cmdline=\"^%%bin^%%\SingleInstanceAccumulator\" -w -d:\" ^^^& echo \" \"-c:cmd /c (echo $files) ^^^| clip\" \"%%1\"

@echo on
::reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\ClipPath\command" /f /ve /t REG_EXPAND_SZ /d "\"^%%bin^%%\SingleInstanceAccumulator\" -w -d:\" ^^^& echo \" \"-c:cmd /c (echo $files) ^^^| clip\" \"%%1\""
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\ClipPath\command" /f /ve /t REG_EXPAND_SZ /d "%cmdline%"
reg add "HKEY_CURRENT_USER\Software\Classes\Folder\shell\ClipPath\command" /f /ve /t REG_EXPAND_SZ /d "%cmdline%"

::fix max selected for context menu
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /f /v MultipleInvokePromptMinimum /t REG_DWORD /d 100

timeout /t 5