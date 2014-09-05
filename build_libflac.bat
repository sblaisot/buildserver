echo "Building FLAC"
set FLAC_PATH=flac-1.3.0

if %MACHINE_X86% (
  set PLATFORM=Win32
) else (
  set PLATFORM=x64
)

if %CONFIG_RELEASE% (
  set CONFIG=Release
) else (
  set CONFIG=Debug
)

cd build\%FLAC_PATH%\src\libFLAC\
%MSBUILD% libFLAC_dynamic.sln /p:Configuration=%CONFIG% /p:Platform=%PLATFORM% /t:libFLAC_dynamic:Clean;libFLAC_dynamic:Rebuild

copy %PLATFORM%\%CONFIG%\libFLAC_dynamic.lib %LIB_DIR%\libFLAC.lib
copy %PLATFORM%\%CONFIG%\libFLAC_dynamic.dll %LIB_DIR%\libFLAC.dll
md %INCLUDE_DIR%\FLAC
copy ..\..\include\FLAC\*.h %INCLUDE_DIR%\FLAC\

cd %ROOT_DIR%