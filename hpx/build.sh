#!/usr/bin/env bash
set -e

mkdir build
pushd build

if [[ "$(uname -s)" == "Darwin" ]]; then
    # https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
    export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
elif [[ "$(uname -s)" == "linux-aarch64" ]]; then
    export CMAKE_ARGS="${CMAKE_ARGS} -DHPX_WITH_GENERIC_CONTEXT_COROUTINES=On"
fi

cmake \
    -G"Ninja" \
    ${CMAKE_ARGS} \
    -D CMAKE_INSTALL_LIBDIR=lib \
    -D Python_EXECUTABLE="python" \
    -D HPX_WITH_EXAMPLES=FALSE \
    -D HPX_WITH_MALLOC="${malloc:-tcmalloc}" \
    -D HPX_WITH_NETWORKING=FALSE \
    -D HPX_WITH_TESTS=FALSE \
    -D HPX_WITH_FETCH_BOOST=ON \
    ..

cmake --build . --config Release --parallel ${CPU_COUNT}
cmake --install .
