set -e

pushd test

if [[ "$target_platform" == "osx-64" ]] || [[ "$target_platform" == "osx-arm64" ]]; then
    # https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake -G "Ninja" -D CMAKE_VERBOSE_MAKEFILE=ON ${CMAKE_ARGS} .

cmake --build . --config Release
./hello_hpx

cmake --install . --prefix hello
hello/bin/hello_hpx
