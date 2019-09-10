################################################################################
# Project:  Lib SpatialIndex
# Purpose:  CMake build scripts
# Author:   Dmitry Baryshnikov, dmitry.baryshnikov@nexgis.com
################################################################################
# Copyright (C) 2017-2018, NextGIS <info@nextgis.com>
#
# Rewrited original cmake script by Marios Hadjieleftheriou. Above ariginal
# header text
#
# top-level CMake configuration file for PDAL
#
# (based originally on the libLAS files copyright Mateusz Loskot)
################################################################################

cmake_minimum_required(VERSION 2.8.12 FATAL_ERROR)
project(spatialindex)

#------------------------------------------------------------------------------
# internal cmake settings
#------------------------------------------------------------------------------

# Some init settings
set(CMAKE_COLOR_MAKEFILE ON)
# Set path to additional CMake modules
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

if(OSX_FRAMEWORK AND (BUILD_SHARED_LIBS OR BUILD_STATIC_LIBS))
  message(FATAL_ERROR "Only OSX_FRAMEWORK key or any or both BUILD_SHARED_LIBS
                       and BUILD_STATIC_LIBS keys are permitted")
endif()

# Name of C++ library

set(SIDX_LIB_NAME spatialindex)
set(SIDX_C_LIB_NAME spatialindex_c)

if(OSX_FRAMEWORK)
    set(INSTALL_BIN_DIR "bin" CACHE INTERNAL "Installation directory for executables" FORCE)
    set(INSTALL_LIB_DIR "Library/Frameworks" CACHE INTERNAL "Installation directory for libraries" FORCE)
    set(INSTALL_CMAKECONF_DIR ${INSTALL_LIB_DIR}/${SIDX_LIB_NAME}.framework/Resources/CMake CACHE INTERNAL "Installation directory for cmake config files" FORCE)
    set(INSTALL_INC_DIR "${INSTALL_LIB_DIR}/${SIDX_LIB_NAME}.framework/Headers" CACHE INTERNAL "Installation directory for headers" FORCE)  # For package paths
    set(SKIP_INSTALL_HEADERS ON)
    set(SKIP_INSTALL_EXECUTABLES ON)
    set(SKIP_INSTALL_FILES ON)
    set(SKIP_INSTALL_EXPORT ON)
    set(CMAKE_MACOSX_RPATH ON)
else()
    include(GNUInstallDirs)
    set(INSTALL_BIN_DIR ${CMAKE_INSTALL_BINDIR} CACHE INTERNAL "Installation directory for executables" FORCE)
    set(INSTALL_LIB_DIR ${CMAKE_INSTALL_LIBDIR} CACHE INTERNAL "Installation directory for libraries" FORCE)
    set(INSTALL_INC_DIR "${CMAKE_INSTALL_INCLUDEDIR}" CACHE INTERNAL "Installation directory for headers" FORCE)
    set(INSTALL_CMAKECONF_DIR ${CMAKE_INSTALL_DATADIR}/${SIDX_LIB_NAME}/CMake CACHE INTERNAL "Installation directory for cmake config files" FORCE)
endif()

#------------------------------------------------------------------------------
# libspatialindex general settings
#------------------------------------------------------------------------------
include(util)
check_version(SIDX_VERSION_MAJOR SIDX_VERSION_MINOR SIDX_VERSION_PATCH SIDX_LIB_VERSION SIDX_LIB_SOVERSION)
set(VERSION ${SIDX_VERSION_MAJOR}.${SIDX_VERSION_MINOR}.${SIDX_VERSION_PATCH})
set(SIDX_VERSION_STRING ${VERSION})

if(OSX_FRAMEWORK)
    set(FRAMEWORK_VERSION "${SIDX_VERSION_MAJOR}")
endif()
report_version(${PROJECT_NAME} ${VERSION})

configure_file(${CMAKE_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake IMMEDIATE @ONLY)

if(WIN32)
  if (MSVC)
    if (MSVC80 OR MSVC90 OR MSVC10 OR MSVC11 OR MSVC12 OR MSVC13)
        if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
            set( SIDX_LIB_NAME "spatialindex-64" )
            set( SIDX_C_LIB_NAME "spatialindex_c-64" )
        else( CMAKE_SIZEOF_VOID_P EQUAL 8 )
            set( SIDX_LIB_NAME "spatialindex-32"  )
            set( SIDX_C_LIB_NAME "spatialindex_c-32"  )
        endif( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    endif()
  endif()
endif()


set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)

include (CheckFunctionExists)

check_function_exists(srand48 HAVE_SRAND48)
check_function_exists(gettimeofday HAVE_GETTIMEOFDAY)
check_function_exists(memset HAVE_MEMSET)
check_function_exists(memcpy HAVE_MEMCPY)
check_function_exists(bcopy HAVE_BCOPY)


include (CheckIncludeFiles)

if (HAVE_SRAND48)
    add_definitions(-DHAVE_SRAND48=1)
endif()

if (HAVE_GETTIMEOFDAY)
    add_definitions(-DHAVE_GETTIMEOFDAY=1)
endif()

if (HAVE_BZERO)
    add_definitions(-DHAVE_BZERO=1)
endif()

if (HAVE_MEMSET)
    add_definitions(-DHAVE_MEMSET=1)
endif()

if (HAVE_MEMCPY)
    add_definitions(-DHAVE_MEMCPY=1)
endif()

if (HAVE_BCOPY)
    add_definitions(-DHAVE_BCOPY=1)
endif()

if (HAVE_PTHREAD_H)
    add_definitions(-DHAVE_PTHREAD_H=1)
endif()

#------------------------------------------------------------------------------
# General build settings
#------------------------------------------------------------------------------

# note we default to debug mode
if(NOT MSVC_IDE)
  if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel" FORCE)
  endif()
  message(STATUS "Setting libspatialindex build type - ${CMAKE_BUILD_TYPE}")
endif()

set(SIDX_BUILD_TYPE ${CMAKE_BUILD_TYPE})

# TODO: Still testing the output paths --mloskot
set(SIDX_BUILD_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")

# Output directory in which to build RUNTIME target files.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${SIDX_BUILD_OUTPUT_DIRECTORY})

# Output directory in which to build LIBRARY target files
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${SIDX_BUILD_OUTPUT_DIRECTORY})

# Output directory in which to build ARCHIVE target files.
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${SIDX_BUILD_OUTPUT_DIRECTORY})


#------------------------------------------------------------------------------
# Platform and compiler specific settings
#------------------------------------------------------------------------------

if(WIN32)
  if (MSVC)
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
    add_definitions(-D_CRT_NONSTDC_NO_WARNING)
    add_definitions(-D_SCL_SECURE_NO_WARNINGS)
    add_definitions(-DSPATIALINDEX_CREATE_DLL=1)
    add_definitions(-DNOMINMAX)
    set(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4068")

    if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
      string(REGEX REPLACE "/W[0-4]" "/W4"
        CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
    else()
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
    endif()
  endif()

else()
  # not WIN32

  # Recommended C++ compilation flags
  # -Weffc++
  set(SIDX_COMMON_CXX_FLAGS
    "-pedantic -Wall -Wpointer-arith -Wcast-align -Wcast-qual  -Wredundant-decls -Wno-long-long")

  if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SIDX_COMMON_CXX_FLAGS}")
    if (CMAKE_COMPILER_IS_GNUCXX AND NOT CMAKE_SYSTEM_NAME STREQUAL "CYGWIN")
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    endif()

    set(SIDX_COMPILER_GCC 1)

  elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang" OR "${CMAKE_CXX_COMPILER}" MATCHES "clang")
    set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS} ${SIDX_COMMON_CXX_FLAGS}")
    set(SIDX_COMPILER_CLANG 1)
  endif()
endif(WIN32)

if (APPLE)
  set(SO_EXT dylib)
  set(CMAKE_FIND_FRAMEWORK "LAST")
elseif(WIN32)
  set(SO_EXT dll)
else()
  set(SO_EXT so)
endif(APPLE)


#------------------------------------------------------------------------------
# installation path settings
#------------------------------------------------------------------------------

#if(WIN32)
#  set(DEFAULT_LIB_SUBDIR lib)
#  set(DEFAULT_DATA_SUBDIR .)
#  set(DEFAULT_INCLUDE_SUBDIR include)

#  if (MSVC)
#    set(DEFAULT_BIN_SUBDIR bin)
#  else()
#    set(DEFAULT_BIN_SUBDIR .)
#  endif()
#else()
  # Common locations for Unix and Mac OS X
#  set(DEFAULT_BIN_SUBDIR bin)
#  set(DEFAULT_LIB_SUBDIR lib${LIB_SUFFIX})
#  set(DEFAULT_DATA_SUBDIR share/spatialindex)
#  set(DEFAULT_INCLUDE_SUBDIR include)
#endif()

# Locations are changeable by user to customize layout of SIDX installation
# (default values are platform-specific)
#set(SIDX_BIN_SUBDIR ${DEFAULT_BIN_SUBDIR} CACHE STRING
#  "Subdirectory where executables will be installed")
#set(SIDX_LIB_SUBDIR ${DEFAULT_LIB_SUBDIR} CACHE STRING
#  "Subdirectory where libraries will be installed")
#set(SIDX_INCLUDE_SUBDIR ${DEFAULT_INCLUDE_SUBDIR} CACHE STRING
#  "Subdirectory where header files will be installed")
#set(SIDX_DATA_SUBDIR ${DEFAULT_DATA_SUBDIR} CACHE STRING
#  "Subdirectory where data will be installed")

# Mark *_SUBDIR variables as advanced and dedicated to use by power-users only.
#mark_as_advanced(SIDX_BIN_SUBDIR
#  SIDX_LIB_SUBDIR SIDX_INCLUDE_SUBDIR SIDX_DATA_SUBDIR)

# Full paths for the installation
#set(SIDX_BIN_DIR ${SIDX_BIN_SUBDIR})
#set(SIDX_LIB_DIR ${SIDX_LIB_SUBDIR})
#set(SIDX_INCLUDE_DIR ${SIDX_INCLUDE_SUBDIR})
#set(SIDX_DATA_DIR ${SIDX_DATA_SUBDIR})


set(PACKAGE_NAME ${PROJECT_NAME})
string(TOUPPER ${PACKAGE_NAME} PACKAGE_UPPER_NAME)

#------------------------------------------------------------------------------
# subdirectory controls
#------------------------------------------------------------------------------

add_subdirectory(src)
enable_testing()
if(BUILD_TESTS)
    add_subdirectory(test)
endif()

# uninstall
add_custom_target(uninstall COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

# Export package ===============================================================

if(REGISTER_PACKAGE)
    # Export the package for use from the build-tree
    # (this registers the build-tree with a global CMake-registry)
    export(PACKAGE ${PACKAGE_UPPER_NAME})
endif()

# Create the <Package>Config.cmake file
configure_file(cmake/PackageConfig.cmake.in
    ${PROJECT_BINARY_DIR}/${PACKAGE_UPPER_NAME}Config.cmake @ONLY)

# Archiving ====================================================================

set(CPACK_PACKAGE_NAME "${PACKAGE_NAME}")
set(CPACK_PACKAGE_VENDOR "${PACKAGE_VENDOR}")
set(CPACK_PACKAGE_VERSION "${VERSION}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${PACKAGE_NAME} Installation")
set(CPACK_PACKAGE_RELOCATABLE TRUE)
set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)
set(CPACK_GENERATOR "ZIP")
set(CPACK_MONOLITHIC_INSTALL ON)
set(CPACK_STRIP_FILES TRUE)

# Get cpack zip archive name
get_cpack_filename(${VERSION} PROJECT_CPACK_FILENAME)
set(CPACK_PACKAGE_FILE_NAME ${PROJECT_CPACK_FILENAME})

include(CPack)
