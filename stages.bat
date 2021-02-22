@echo off
set echo=off
echo %echo%

rem    Copyright 2020 Antenna House, Inc.

setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

rem Directory locations
set PWD=%cd%
set SOURCE=VAC7237.xml
set USE_ANALYZER_BAT=../analysis-utility/analyzer.bat
set USE_SAXON=E:/saxon/9.9/saxon9he.jar
set USE_AHFCMD="%AHF71_64_HOME%/AHFCmd.exe"
set USE_STAGE=all

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
set __long_param= ahfcmd analyzer saxon stage

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

if not "%analyzer%"=="" (
   if EXIST "%analyzer%" (
      set ANALYZER_BAT="%analyzer%"
   ) else (
      echo Analyzer batch file does not exist: %analyzer%
      goto error
   )
) else (
   set ANALYZER_BAT=%USE_ANALYZER_BAT%
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

if not "%stage%"=="" (
      set STAGE=%stage%
) else (
   set STAGE=%USE_STAGE%
)

if "%STAGE%"=="all" goto stage_1_do
if "%STAGE%"=="1" goto stage_1_do
goto stage_1_done
:stage_1_do
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

:stage_1_done

if "%STAGE%"=="all" goto stage_2_do
if "%STAGE%"=="2" goto stage_2_do
goto stage_2_done
:stage_2_do

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

:stage_2_done

if "%STAGE%"=="all" goto stage_3_do
if "%STAGE%"=="3" goto stage_3_do
goto stage_3_done
:stage_3_do

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

:stage_3_done

if "%STAGE%"=="all" goto stage_4_do
if "%STAGE%"=="4" goto stage_4_do
goto stage_4_done
:stage_4_do

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

:stage_4_done

if "%STAGE%"=="all" goto stage_5_do
if "%STAGE%"=="5" goto stage_5_do
goto stage_5_done
:stage_5_do

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

call %ANALYZER_BAT% -d stage5_consecutive-hyphens.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml" -ahfcmd %AHFCMD% -show no

echo %echo%

:stage_5_done

if "%STAGE%"=="all" goto stage_6_do
if "%STAGE%"=="6" goto stage_6_do
goto stage_6_done
:stage_6_do

echo.
echo Stage 6: White-space

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage6_white-space.fo" "white-space.xsl" "consecutive-hyphens.xsl" "line-start-end.xsl" "paragraph-widow-2.xsl" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml" "white-space-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage6_white-space.fo" goto stage_6_fo_do

echo 'stage6_white-space.fo' is up to date

goto stage_6_fo_done

:stage_6_fo_do

if exist "stage6_white-space.fo" del "stage6_white-space.fo"
if exist "stage6_white-space.fo" (
   echo Unable to replace 'stage6_white-space.fo'
   goto error
)

echo Generating 'stage6_white-space.fo'

java -jar %SAXON% %SOURCE% white-space.xsl > stage6_white-space.fo

:stage_6_fo_done

call %ANALYZER_BAT% -d stage6_white-space.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml -i white-space-settings.xml" -ahfcmd %AHFCMD% -show no

echo %echo%

:stage_6_done

if "%STAGE%"=="all" goto stage_7_do
if "%STAGE%"=="7" goto stage_7_do
goto stage_7_done
:stage_7_do

echo.
echo Stage 7: river

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage7_river.fo" "river.xsl" "white-space.xsl" "line-start-end.xsl" "paragraph-widow-2.xsl" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml" "white-space-settings.xml" "river-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage7_river.fo" goto stage_7_fo_do

echo 'stage7_river.fo' is up to date

goto stage_7_fo_done

:stage_7_fo_do

if exist "stage7_river.fo" del "stage7_river.fo"
if exist "stage7_river.fo" (
   echo Unable to replace 'stage7_river.fo'
   goto error
)

echo Generating 'stage7_river.fo'

java -jar %SAXON% %SOURCE% river.xsl > stage7_river.fo

:stage_7_fo_done

call %ANALYZER_BAT% -d stage7_river.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml -i white-space-settings.xml -i river-settings.xml" -ahfcmd %AHFCMD% -show no

echo %echo%

:stage_7_done

if "%STAGE%"=="all" goto stage_8_do
if "%STAGE%"=="8" goto stage_8_do
goto stage_8_done
:stage_8_do

echo.
echo Stage 8: lines before and after

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "%SOURCE%" "stage8_lines.fo" "lines.xsl" "river.xsl" "white-space.xsl" "line-start-end.xsl" "paragraph-widow-2.xsl" "tei2fo.xsl" "fo-layout.xsl" "paragraph-widow-settings.xml" "white-space-settings.xml" "river-settings.xml"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage8_lines.fo" goto stage_8_fo_do

echo 'stage8_lines.fo' is up to date

goto stage_8_fo_done

:stage_8_fo_do

if exist "stage8_lines.fo" del "stage8_lines.fo"
if exist "stage8_lines.fo" (
   echo Unable to replace 'stage8_lines.fo'
   goto error
)

echo Generating 'stage8_lines.fo'

java -jar %SAXON% %SOURCE% lines.xsl > stage8_lines.fo

:stage_8_fo_done

rem Sort files by date. Newer file is last to set NEWER.
for /F "usebackq delims=" %%q in (`dir /B /OD "stage8_overrides.fo" "stage8_lines.fo" "show-overrides.xsl"`) do (
    set NEWER=%%q
)

if not "%NEWER%"=="stage8_overrides.fo" goto stage_8_overrides_do

echo 'stage8_overrides.fo' is up to date

goto stage_8_overrides_done

:stage_8_overrides_do

if exist "stage8_overrides.fo" del "stage8_overrides.fo"
if exist "stage8_overrides.fo" (
   echo Unable to replace 'stage8_overrides.fo'
   goto error
)

echo Generating 'stage8_overrides.fo'

java -jar %SAXON% stage8_lines.fo show-overrides.xsl > stage8_overrides.fo

:stage_8_overrides_done

call %ANALYZER_BAT% -d stage8_overrides.fo -format report -opt "-x 4 -i paragraph-widow-settings.xml -i white-space-settings.xml -i river-settings.xml" -ahfcmd %AHFCMD%

echo %echo%

:stage_8_done

echo.

rem ----------------------------------------------------------------------
:done

exit /B 0

rem ----------------------------------------------------------------------
:error
exit /B 1
