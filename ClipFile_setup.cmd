setlocal

reg delete "HKEY_CURRENT_USER\Software\Classes\*\shell\File2Clip" /f

::create the entry
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\ClipFile" /f /ve /d "ClipFile"

:: "delims=" includes spaces in elevator path
for /f "delims=" %%v in ('where elevator') do set elevatorpath=%%~fv
if %errorlevel% GTR 0 (echo elevator.exe not found in path & pause & exit /b)

::escaping is really hard to remember since there's about 3 levels of passthrough going on here
::first we have reg add doing some processing so we need regular outer quotes around our value after /d
::and we want reg add to pass through quotes around our elevator command path and -c arguments so we escape those once with \"
::then we want that command line stored in the registry to pass quotes around the inner command and args after -c so we escape both the slash and the quote
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell\ClipFile\command" /f /ve /t REG_EXPAND_SZ /d "\"%elevatorpath%\" -hide -c \"\\\"%~dp0ClipFile.cmd\\\" \\\"%%L\\\"\"
::in the registry we want it to wind up like this
::  "c:\bin\Elevator.exe" -v -c "\"C:\Users\banderson\OneDrive - PERK\Brent\bin\ClipFile\ClipFile.cmd\" \"%L\""
::then elevator receives this:
::  ApplicationName: C:\WINDOWS\system32\cmd.exe
::  CommandLine:     /s /c ""C:\Users\banderson\OneDrive - PERK\Brent\bin\ClipFile\ClipFile.cmd" "\\kc.kingcounty.lcl\dnrp\LAB\IT\Vacation Planning\2018 Holidays Vacation Planning.xlsx" "
::and lastly the /s from elevator removes the outer quotes after /c above, piece of cake right? :)

::set as the default command on .zip file double click
reg add "HKEY_CURRENT_USER\Software\Classes\*\shell" /f /ve /t REG_SZ /d ClipFile

@timeout /t 5