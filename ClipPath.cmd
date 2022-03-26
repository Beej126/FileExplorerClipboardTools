setlocal enabledelayedexpansion
:: ~ removes surrounding quotes so we don't double up
:: f expands to full path
set f=%~f1
:: remove double slashes 
set f=%f:\\=%
:: replace spaces with %20 (i.e. poor mans url encode)
::set "repl=%%20"
::set f=%f: =!repl!%

echo file://%f% | clip
