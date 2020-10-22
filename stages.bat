@echo off
set echo=off
echo %echo%

rem    Copyright 2020 Antenna House, Inc.

setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem Directory locations
set PWD=%cd%
set SOURCE=VAC7237.xml
set ANALYZER_BAT=../analysis-utility/analyzer.bat
set USE_SAXON=E:/saxon/9.9/saxon9he.jar
set USE_AHFCMD=E:/Projects/V70/Windows_X86_64E/AHFCmd.exe

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

echo Stage 1: Base

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage1_base.fo" "tei2fo.xsl" "fo-layout.xsl"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage1_base.fo" goto stage_1_fo_do

echo 'stage1_base.fo' is up to date

goto stage_1_fo_done

:stage_1_fo_do

if exist "stage1_base.fo" del "stage1_base.fo"
if exist "stage1_base.fo" (
   echo Unable to replace 'stage1_base.fo'.
   goto error
)

echo Generating 'stage1_base.fo'

java -jar %SAXON% %SOURCE% tei2fo.xsl > stage1_base.fo

:stage_1_fo_done

call %ANALYZER_BAT% -d stage1_base.fo -format report -opt "-x 4" -ahfcmd %AHFCMD% -show no

echo %echo%

echo.
echo Stage 2: Paragraph Widow 1

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage2_paragraph-widow-1.fo" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage2_paragraph-widow-1.fo" goto stage_2_fo_do

echo 'stage2_paragraph-widow-1.fo' is up to date

goto stage_2_fo_done

:stage_2_fo_do

if exist "stage2_paragraph-widow-1.fo" del "stage2_paragraph-widow-1.fo"
if exist "stage2_paragraph-widow-1.fo" (
   echo Unable to replace 'stage2_paragraph-widow-1.fo'
   goto error
)

echo Generating 'stage2_paragraph-widow-1.fo'

java -jar %SAXON% %SOURCE% tei2fo.xsl > stage2_paragraph-widow-1.fo

:stage_2_fo_done

call %ANALYZER_BAT% -d stage2_paragraph-widow-1.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml" -ahfcmd %AHFCMD% -show no

echo %echo%

echo.
echo Stage 3: Paragraph Widow 2

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage3_paragraph-widow-2.fo" "paragraph-widow-2.xsl" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage3_paragraph-widow-2.fo" goto stage_3_fo_do

echo 'stage3_paragraph-widow-2.fo' is up to date

goto stage_3_fo_done

:stage_3_fo_do

if exist "stage3_paragraph-widow-2.fo" del "stage3_paragraph-widow-2.fo"
if exist "stage3_paragraph-widow-2.fo" (
   echo Unable to replace 'stage3_paragraph-widow-2.fo'
   goto error
)

echo Generating 'stage3_paragraph-widow-2.fo'

java -jar %SAXON% %SOURCE% paragraph-widow-2.xsl > stage3_paragraph-widow-2.fo

:stage_3_fo_done

call %ANALYZER_BAT% -d stage3_paragraph-widow-2.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml" -ahfcmd %AHFCMD% -show no

echo %echo%

echo.
echo Stage 4: Line Start and End

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage4_line-start-end.fo" "line-start-end.xsl" "paragraph-widow-2.xsl" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage4_line-start-end.fo" goto stage_4_fo_do

echo 'stage4_line-start-end.fo' is up to date

goto stage_4_fo_done

:stage_4_fo_do

if exist "stage4_line-start-end.fo" del "stage4_line-start-end.fo"
if exist "stage4_line-start-end.fo" (
   echo Unable to replace 'stage4_line-start-end.fo'
   goto error
)

echo Generating 'stage4_line-start-end.fo'

java -jar %SAXON% %SOURCE% line-start-end.xsl > stage4_line-start-end.fo

:stage_4_fo_done

call %ANALYZER_BAT% -d stage4_line-start-end.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml" -ahfcmd %AHFCMD% -show no

echo %echo%

echo.
echo Stage 5: Consecutive Hyphens

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage5_consecutive-hyphens.fo" "consecutive-hyphens.xsl" "line-start-end.xsl" "paragraph-widow-2.xsl" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage5_consecutive-hyphens.fo" goto stage_5_fo_do

echo 'stage5_consecutive-hyphens.fo' is up to date

goto stage_5_fo_done

:stage_5_fo_do

if exist "stage5_consecutive-hyphens.fo" del "stage5_consecutive-hyphens.fo"
if exist "stage5_consecutive-hyphens.fo" (
   echo Unable to replace 'stage5_consecutive-hyphens.fo'
   goto error
)

echo Generating 'stage5_consecutive-hyphens.fo'

java -jar %SAXON% %SOURCE% consecutive-hyphens.xsl > stage5_consecutive-hyphens.fo

:stage_5_fo_done

call %ANALYZER_BAT% -d stage5_consecutive-hyphens.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml" -ahfcmd %AHFCMD%

echo %echo%

echo.

rem ----------------------------------------------------------------------
:done

exit /B 0

rem ----------------------------------------------------------------------
:error
exit /B 1
