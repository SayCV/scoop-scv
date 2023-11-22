@chcp 65001
@echo off&SetLocal EnableDelayedExpansion
cd /d "%~dp0"

if not exist apps.ini cd.>apps.ini&echo :: Please set update apps in apps.ini&PAUSE&EXIT 0

@set /a tee=0
@set /a errcnt=0
@if "xy" == "xy" @for /f "tokens=1*" %%I in (apps.ini) do @(
    set /a tee+=1
    if not "x%%I" == "x" if "xy" == "xy" (
        echo :: Updating %%I
        call powershell ./bin/%~n0.ps1 %%I -u
        if not %errorlevel% == 0 set /a errcnt+=1
    )
)

if not %errcnt% == 0 (
    echo :: Detected update failed at %errcnt% postions.
    delay 20 2>nul || ping -n 20 127.0.0.1>nul
    EXIT 0
)

echo,
timeout /t 10 2>NUL || DELAY 10 2>NUL || ping -n 10 127.0.0.1>NUL
EXIT 0
