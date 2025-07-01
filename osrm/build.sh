#!/usr/bin/env bash
set -e


sed -i -e "s/add_warning(error)/#add_warning(error)/g" 'cmake/warnings.cmake'

BUILDDIR="build"

mkdir -p ${BUILD_DIR}

CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY" \
cmake ${CMAKE_ARGS} \
  -S ${SRC_DIR} \
  -B ${BUILD_DIR} \
  -G "Ninja" \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX="${PREFIX}"\
  -D ENABLE_LTO=ON \
  -D ENABLE_CONAN=OFF \
  -D BUILD_SHARED_LIBS=ON \
  -D ENABLE_CCACHE=OFF

cmake --build ${BUILD_DIR} --config Release --target all --parallel ${CPU_COUNT}

cmake --build ${BUILD_DIR} --config Release --target install

