################################################################################
# Project:  external projects
# Purpose:  CMake build scripts
# Author:   Dmitry Baryshnikov, polimax@mail.ru
################################################################################
# Copyright (C) 2015, NextGIS <info@nextgis.com>
# Copyright (C) 2015 Dmitry Baryshnikov
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

function(check_version major minor rev lib sover)

    set(CHECK_FILE ${CMAKE_CURRENT_SOURCE_DIR}/include/spatialindex/Version.h)
    file(READ ${CHECK_FILE} VERSION_H_CONTENTS)

    string(REGEX MATCH "SIDX_VERSION_MAJOR[ \t]+([0-9]+)"
        MAJOR_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
        MAJOR_VERSION ${MAJOR_VERSION})
    string(REGEX MATCH "SIDX_VERSION_MINOR[ \t]+([0-9]+)"
        MINOR_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
        MINOR_VERSION ${MINOR_VERSION})
    string(REGEX MATCH "SIDX_VERSION_REV[ \t]+([0-9]+)"
        REV_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
        REV_VERSION ${REV_VERSION})
    string(REGEX MATCH "SIDX_VERSION_BUILD[ \t]+([0-9]+)"
        BLD_VERSION ${VERSION_H_CONTENTS})
    string (REGEX MATCH "([0-9]+)"
        BLD_VERSION ${BLD_VERSION})

    set(${major} ${MAJOR_VERSION} PARENT_SCOPE)
    set(${minor} ${MINOR_VERSION} PARENT_SCOPE)
    set(${rev} ${REV_VERSION} PARENT_SCOPE)
    set(${lib} "4.1.0" PARENT_SCOPE)
    set(${sover} "4" PARENT_SCOPE)

    # Store version string in file for installer needs
    file(TIMESTAMP ${CHECK_FILE} VERSION_DATETIME "%Y-%m-%d %H:%M:%S" UTC)
    file(WRITE ${CMAKE_BINARY_DIR}/version.str "${MAJOR_VERSION}.${MINOR_VERSION}.${REV_VERSION}\n${VERSION_DATETIME}")

endfunction(check_version)

function(report_version name ver)

    string(ASCII 27 Esc)
    set(BoldYellow  "${Esc}[1;33m")
    set(ColourReset "${Esc}[m")

    message(STATUS "${BoldYellow}${name} version ${ver}${ColourReset}")

endfunction()


# macro to find packages on the host OS
macro( find_exthost_package )
    if(CMAKE_CROSSCOMPILING)
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
        if( CMAKE_HOST_WIN32 )
            SET( WIN32 1 )
            SET( UNIX )
        elseif( CMAKE_HOST_APPLE )
            SET( APPLE 1 )
            SET( UNIX )
        endif()
        find_package( ${ARGN} )
        SET( WIN32 )
        SET( APPLE )
        SET( UNIX 1 )
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
    else()
        find_package( ${ARGN} )
    endif()
endmacro()


# macro to find programs on the host OS
macro( find_exthost_program )
    if(CMAKE_CROSSCOMPILING)
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER )
        if( CMAKE_HOST_WIN32 )
            SET( WIN32 1 )
            SET( UNIX )
        elseif( CMAKE_HOST_APPLE )
            SET( APPLE 1 )
            SET( UNIX )
        endif()
        find_program( ${ARGN} )
        SET( WIN32 )
        SET( APPLE )
        SET( UNIX 1 )
        set( CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY )
        set( CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY )
    else()
        find_program( ${ARGN} )
    endif()
endmacro()
