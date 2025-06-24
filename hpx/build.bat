mkdir build
pushd build
if errorlevel 1 exit /b 1

cmake ^
    %CMAKE_ARGS% ^
    -D PYTHON_EXECUTABLE="%PYTHON%" ^
    -D CMAKE_INSTALL_LIBDIR=lib ^
    -D HPX_WITH_EXAMPLES=FALSE ^
    -D HPX_WITH_MALLOC="mimalloc" ^
    -D HPX_WITH_NETWORKING=FALSE ^
    -D HPX_WITH_TESTS=FALSE ^
    ..
if errorlevel 1 exit /b 1

cmake --build . --config Release --parallel %CPU_COUNT%
if errorlevel 1 exit /b 1

cmake --install .
if errorlevel 1 exit /b 1
