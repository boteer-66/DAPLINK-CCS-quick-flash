@echo off
set PROJECT=%1
  
if "%PROJECT%"=="" (
    for /f "delims=" %%F in ('dir /s /b /o:-d "%CD%\*.out"') do (
        echo %%F | findstr "\\Debug\\" >nul
        if not errorlevel 1 (
            set "OUTFILE=%%F"
            goto found
        )
    )
    echo [ERR] No .out found
    exit /b 1
)

set "OUTFILE=%CD%\%PROJECT%\Debug\%PROJECT%.out"
if not exist "%OUTFILE%" set "OUTFILE=%CD%\Debug\%PROJECT%.out"
if not exist "%OUTFILE%" (
    echo [ERR] Not found
    exit /b 1
)
goto flash

:found
for %%A in ("%OUTFILE%\..\..") do set "PROJECT=%%~nxA"

:flash
set "OUTFILE_UNIX=%OUTFILE:\=/%"
echo ==== %PROJECT% ====
D:\openocd\bin\openocd.exe -f interface/cmsis-dap.cfg -f target/ti/mspm0.cfg -c "adapter speed 4000" -c "program %OUTFILE_UNIX%  reset exit"
if %ERRORLEVEL% EQU 0 (
    echo [OK] Done
) else (
    echo [FAIL] Check wiring
    pause
)
