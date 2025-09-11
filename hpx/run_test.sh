set -ev

pushd test

if [[ "$(uname -s)" == "Darwin" ]]; then
    # https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi


echo "**************************************************************************************************"
echo "a " "$target_platform" " " $target_platform
echo "$CXXFLAGS"
echo "**************************************************************************************************"


cmake -G "Ninja" -D CMAKE_VERBOSE_MAKEFILE=ON ${CMAKE_ARGS} .

cmake --build . --config Release
./hello_hpx


cmake --install . --prefix hello

echo "**************************************************************************************************"
pwd
echo "**************************************************************************************************"
find .
echo "**************************************************************************************************"
find . -name hello_hpx
echo "**************************************************************************************************"
ls -altr hello/bin/hello_hpx
echo "**************************************************************************************************"

hello/bin/hello_hpx
