setlocal EnableDelayedExpansion


set BUILD_DIR=build

mkdir %BUILD_DIR%

cmake %CMAKE_ARGS% \
  -S %SRC_DIR% ^
  -B %BUILD_DIR% ^
  -G "Ninja" ^
  -D CMAKE_BUILD_TYPE=Release ^
  -D CMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
  -D ENABLE_LTO=ON ^
  -D ENABLE_CONAN=OFF ^
  -D BUILD_SHARED_LIBS=ON ^
  -D ENABLE_CCACHE=OFF

if errorlevel 1 exit 1

cmake --build %BUILD_DIR% --target all

if errorlevel 1 exit 1

cmake --build %BUILD_DIR% --target install

if errorlevel 1 exit 1
