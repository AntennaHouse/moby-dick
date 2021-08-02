@echo off
set echo=off
echo %echo%

rem    Copyright 2020-2021 Antenna House, Inc.

setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem Directory locations
set PWD=%cd%
set SOURCE=moby-dick-tei\VAC7237.xml
set USE_SAXON=E:/saxon/9.9/saxon9he.jar
set USE_AHFCMD="%AHF71_64_HOME%/AHFCmd.exe"

rem Command-line parameter defaults (possibly used in 'usage' message)
set ahfcmd=
set saxon=

rem ----------------------------------------------------------------------
:start

rem Command-line argument handling based on:
rem    https://stackoverflow.com/a/32078177
rem    https://stackoverflow.com/a/54234876

rem List of names of recognized parameters that do not require a value.
rem There must be at least one space (' ') at the beginning and end of
rem the list and between parameter names.
set __short_param=

rem List of names of recognized parameters that require a value.
rem There must be at least one space (' ') at the beginning and end of
rem the list and between parameter names.
set __long_param= ahfcmd saxon

rem List of all recognized parameter names.
rem There must be at least one space (' ') at the beginning and end of
rem the list and between parameter names.
set __all_param= %__short_param% %__long_param%  

set __expect_param_name=yes

:initial
if "%~1"=="" goto parameters_done
if "%~1"=="--" (
   shift
   goto parameters_done
)

rem echo              %1
set aux=%~1
rem if "%__expect_param_name%"=="yes" (
if not "%__expect_param_name%"=="yes" goto parameters_value
if "%aux:~0,1%"=="-" (
   rem Parameter name.
   set __param=%aux:~1,250%
   rem Parameter name with a space charater before and after the name.
   rem You can't see the final ' ', but it has to be there.
   set __param_tmp= %aux:~1,250% 
   rem echo __param: "!__param!"
   rem echo __param: "%__param%"
   rem echo __param_tmp: "!__param_tmp!"
   rem echo __param_tmp: "%__param_tmp%"
   rem The two strings match only if __param is not in the list.
   call set __param_removed=%%__all_param:!__param_tmp!=%%
   rem Remove transient variables
   set __param_tmp=
   rem echo __param_removed: "!__param_removed!"
   rem echo __param_removed: "%__param_removed%"
   rem set __param_removed=
   set __expect_param_name=
   shift
   goto initial
) else (
  echo.
  echo Expected a parameter starting with "-": %aux%
  goto usage_command_line
  )
:parameters_value
rem ) else (
   rem echo __param_removed: "!__param_removed!"
   rem echo __param_removed: "%__param_removed%"
   rem List of all parameter names, possibly with __param removed.
   if "x%__param_removed%"=="x%__all_param%" (
      echo.
      echo Unrecognized parameter: -!__param!
      goto usage_command_line
   )
   set "%__param%=%~1"
   set __param=
   set __expect_param_name=yes
rem )
shift
goto initial
:parameters_done

if not "%ahfcmd%"=="" (
   if EXIST "%ahfcmd%" (
      set AHFCMD="%ahfcmd%"
   ) else (
      echo AHFCmd file does not exist: %ahfcmd%
      goto error
   )
) else (
   set ahfcmd=%USE_AHFCMD%
)

if not "%saxon%"=="" (
   if EXIST "%saxon%" (
      set SAXON="%saxon%"
   ) else (
      echo Saxon file does not exist: %saxon%
      goto error
   )
) else (
   set SAXON=%USE_SAXON%
)

set opt=

echo.
echo Formatting 'Moby-Dick'.

if exist "moby-dick.fo" del "moby-dick.fo"
if exist "moby-dick.fo" (
   echo Unable to replace 'moby-dick.fo'
   goto error
)

echo Generating 'moby-dick.fo'

java -jar %SAXON% %SOURCE% unbalanced.xsl > moby-dick.fo

:fo_done

echo %echo%

call :sub_2pdf "%PWD%\moby-dick.fo" "%PWD%\moby-dick.pdf" "%PWD%\moby-dick.pdf.log" "%opt%"

if %ERRORLEVEL% NEQ 0 (
   echo An error occurred when generating '%BASENAME%.pdf'. Check log file '%BASENAME%.pdf.log'.
   goto error
)

:pdf_done

echo.

rem ----------------------------------------------------------------------
:done

exit /B 0

rem ----------------------------------------------------------------------
:error
exit /B 1

rem ----------------------------------------------------------------------
rem Subroutines

:sub_basename_ext
rem echo %1 %2
set "%~1=%~nx2"
exit /B 1

:sub_2pdf

set SOURCE=%~1
set TARGET=%~2
set LOG=%~3
set PDF_OPT=%~4

rem If the PDF is open in Acrobat, it can't be either deleted or replaced.
if exist "%TARGET%" del "%TARGET%"
if exist "%TARGET%" (
   echo Unable to replace '%TARGET%'.
   exit /B 1
)

set SOURCE_BASENAME=
call :sub_basename_ext SOURCE_BASENAME "%SOURCE%"

set TARGET_BASENAME=
call :sub_basename_ext TARGET_BASENAME "%TARGET%"

echo Formatting '%SOURCE_BASENAME%' as '%TARGET_BASENAME%'
rem Use highest-possible PDF version in case embedding high-version PDF
%AHFCMD% -x 4 %PDF_OPT% -d "%SOURCE%" -o "%TARGET%" 2> "%LOG%"

if %ERRORLEVEL% NEQ 0 (
   echo An error occurred when generating '%TARGET%'. Check log file '%LOG%'.
   exit /B 1
)
exit /B 0

rem From https://www.dostips.com/forum/viewtopic.php?p=38229#p38229
:sub_file_mod_time  File  [TimeVar]
::
::  Computes the Unix time (epoch time) for the last modified timestamp for File.
::  The result is an empty string if the file does not exist. Stores the result
::  in TimeVar, or prints the result if TimeVar is not specified.
::
::  Unix time = number of seconds since midnight, January 1, 1970 GMT
::
setlocal disableDelayedExpansion
:: Get full path of file (short form if possible)
for %%F in ("%~1") do set "file=%%~sF"
:: Get last modified time in YYYYMMDDHHMMSS format
set "time="
for /f "skip=1 delims=,. tokens=2" %%A in (
  'wmic datafile where name^="%file:\=\\%" get lastModified /format:csv 2^>nul'
) do set "ts=%%A"
set "ts=%ts%"
:: Convert time to Unix time (aka epoch time)
if defined ts (
  set /a "yy=10000%ts:~0,4% %% 10000, mm=100%ts:~4,2% %% 100, dd=100%ts:~6,2% %% 100"
  set /a "dd=dd-2472663+1461*(yy+4800+(mm-14)/12)/4+367*(mm-2-(mm-14)/12*12)/12-3*((yy+4900+(mm-14)/12)/100)/4"
  set /a "ss=(((1%ts:~8,2%*60)+1%ts:~10,2%)*60)+1%ts:~12,2%-366100-%ts:~21,1%((1%ts:~22,3%*60)-60000)"
  set /a "ts=ss+dd*86400"
)
:: Return the result
endlocal & if "%~2" neq "" (set "%~2=%ts%") else echo(%ts%
