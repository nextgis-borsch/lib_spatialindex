#
# top-level CMake configuration file for libspatialindex
#
# (based originally on the PDAL and libLAS files copyright Mateusz Loskot)

cmake_minimum_required(VERSION 3.16.3)

#------------------------------------------------------------------------------
# libspatialindex general settings
#------------------------------------------------------------------------------


project(spatialindex
  LANGUAGES CXX
  VERSION "2.0.0"
  HOMEPAGE_URL "https://github.com/libspatialindex/libspatialindex"
)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/borsch/cmake/version.cmake)
report_version(spatialindex ${PROJECT_VERSION})
write_version(${CMAKE_CURRENT_SOURCE_DIR}/ChangeLog 2 0 0)


set(SIDX_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(SIDX_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(SIDX_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
set(SIDX_VERSION_STRING "${PROJECT_VERSION}")

set(SIDX_LIB_VERSION "7.0.0")
set(SIDX_LIB_SOVERSION "7")

include(GNUInstallDirs)


IF(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE Release CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel"
        FORCE)
ENDIF()


message(STATUS
  "Configuring CMake ${CMAKE_VERSION} to build spatialindex ${PROJECT_VERSION}")

include(CTest)
option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Enables integrated test suites" OFF)

if(DEFINED SIDX_BUILD_TESTS)
  message(DEPRECATION "SIDX_BUILD_TESTS has been replaced with BUILD_TESTING")
  set(BUILD_TESTING ${SIDX_BUILD_TESTS})
endif()
include(CTest)

# C++11 required, overridable by user
set(CMAKE_CXX_STANDARD 11
  CACHE STRING "C++ standard version to use (default is 11)")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Name of C++ library
set(SIDX_LIB_NAME spatialindex)
set(SIDX_C_LIB_NAME spatialindex_c)

if(WIN32 AND MSVC)
  if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(SIDX_LIB_NAME "${SIDX_LIB_NAME}-64")
    set(SIDX_C_LIB_NAME "${SIDX_C_LIB_NAME}-64")
  else()
    set(SIDX_LIB_NAME "${SIDX_LIB_NAME}-32")
    set(SIDX_C_LIB_NAME "${SIDX_C_LIB_NAME}-32")
  endif()
endif()


set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)

include(CheckFunctionExists)

check_function_exists(srand48 HAVE_SRAND48)
check_function_exists(gettimeofday HAVE_GETTIMEOFDAY)
check_function_exists(memset HAVE_MEMSET)
check_function_exists(memcpy HAVE_MEMCPY)
check_function_exists(bcopy HAVE_BCOPY)


include(CheckIncludeFiles)

add_subdirectory(src)

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

#------------------------------------------------------------------------------
# Packaging
#------------------------------------------------------------------------------
include(${CMAKE_CURRENT_LIST_DIR}/cmake/borsch/cmake/packaging.cmake)
create_borsch_package(${PROJECT_NAME}
  VENDOR NextGIS
  VERSION ${PROJECT_VERSION}
  TARGETS spatialindex_c spatialindex
  HEADERS_DIRS ${CMAKE_CURRENT_LIST_DIR}/include/spatialindex
)
