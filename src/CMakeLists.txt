###############################################################################
#
# src/CMakeLists.txt controls building of SIDX library
#
# Copyright (c) 2009 Mateusz Loskot <mateusz@loskot.net>
#
###############################################################################

###############################################################################
# Source files specification
#
# Naming format:
#   SIDX_CPP - all the .cpp files
#   SIDX_HPP - all the .hpp files
#   SIDX_<dirname>_CPP - all the .cpp files for the given subdir/namespace
#   ...

set(SIDX_HEADERS_DIR "${PROJECT_SOURCE_DIR}/include/spatialindex/")
set(SIDX_HEADERS_CAPI_DIR "${PROJECT_SOURCE_DIR}/include/spatialindex/capi")
set(SIDX_HPP "")
set(SIDX_CPP "")

set(SIDX_SRC_DIR "${PROJECT_SOURCE_DIR}/src")
set(SIDX_CAPI_DIR "${PROJECT_SOURCE_DIR}/src/capi")

#
# base
#
set(SIDX_BASE_HPP
  "${SIDX_HEADERS_DIR}/LineSegment.h"
  "${SIDX_HEADERS_DIR}/MovingPoint.h"
  "${SIDX_HEADERS_DIR}/MovingRegion.h"
  "${SIDX_HEADERS_DIR}/MVRTree.h"
  "${SIDX_HEADERS_DIR}/Point.h"
  "${SIDX_HEADERS_DIR}/Region.h"
  "${SIDX_HEADERS_DIR}/RTree.h"
  "${SIDX_HEADERS_DIR}/SpatialIndex.h"
  "${SIDX_HEADERS_DIR}/TimePoint.h"
  "${SIDX_HEADERS_DIR}/TimeRegion.h"
  "${SIDX_HEADERS_DIR}/TPRTree.h"
  "${SIDX_HEADERS_DIR}/Version.h"
)
list (APPEND SIDX_HPP ${SIDX_BASE_HPP} )

set(SIDX_CAPI_HPP
  "${SIDX_HEADERS_CAPI_DIR}/BoundsQuery.h"
  "${SIDX_HEADERS_CAPI_DIR}/CountVisitor.h"
  "${SIDX_HEADERS_CAPI_DIR}/CustomStorage.h"
  "${SIDX_HEADERS_CAPI_DIR}/DataStream.h"
  "${SIDX_HEADERS_CAPI_DIR}/Error.h"
  "${SIDX_HEADERS_CAPI_DIR}/IdVisitor.h"
  "${SIDX_HEADERS_CAPI_DIR}/Index.h"
  "${SIDX_HEADERS_CAPI_DIR}/LeafQuery.h"
  "${SIDX_HEADERS_CAPI_DIR}/ObjVisitor.h"
  "${SIDX_HEADERS_CAPI_DIR}/sidx_api.h"
  "${SIDX_HEADERS_CAPI_DIR}/sidx_config.h"
  "${SIDX_HEADERS_CAPI_DIR}/sidx_export.h"
  "${SIDX_HEADERS_CAPI_DIR}/sidx_impl.h"
  "${SIDX_HEADERS_CAPI_DIR}/Utility.h"
)
list (APPEND SIDX_HPP ${SIDX_CAPI_HPP} )

set(SIDX_CAPI_CPP
  "${SIDX_CAPI_DIR}/BoundsQuery.cc"
  "${SIDX_CAPI_DIR}/CountVisitor.cc"
  "${SIDX_CAPI_DIR}/CustomStorage.cc"
  "${SIDX_CAPI_DIR}/DataStream.cc"
  "${SIDX_CAPI_DIR}/Error.cc"
  "${SIDX_CAPI_DIR}/IdVisitor.cc"
  "${SIDX_CAPI_DIR}/Index.cc"
  "${SIDX_CAPI_DIR}/LeafQuery.cc"
  "${SIDX_CAPI_DIR}/ObjVisitor.cc"
  "${SIDX_CAPI_DIR}/sidx_api.cc"
  "${SIDX_CAPI_DIR}/Utility.cc"
)
list (APPEND SIDX_CPP ${SIDX_CAPI_CPP} )


set(SIDX_SPATIALINDEX_CPP
  "${SIDX_SRC_DIR}/spatialindex/LineSegment.cc"
  "${SIDX_SRC_DIR}/spatialindex/MovingPoint.cc"
  "${SIDX_SRC_DIR}/spatialindex/MovingRegion.cc"
  "${SIDX_SRC_DIR}/spatialindex/Point.cc"
  "${SIDX_SRC_DIR}/spatialindex/Region.cc"
  "${SIDX_SRC_DIR}/spatialindex/SpatialIndexImpl.cc"
  "${SIDX_SRC_DIR}/spatialindex/TimePoint.cc"
  "${SIDX_SRC_DIR}/spatialindex/TimeRegion.cc"
)
list (APPEND SIDX_CPP ${SIDX_SPATIALINDEX_CPP} )

set(SIDX_MVRTREE_CPP
  "${SIDX_SRC_DIR}/mvrtree/Index.cc"
  "${SIDX_SRC_DIR}/mvrtree/Index.h"
  "${SIDX_SRC_DIR}/mvrtree/Leaf.cc"
  "${SIDX_SRC_DIR}/mvrtree/Leaf.h"
  "${SIDX_SRC_DIR}/mvrtree/MVRTree.cc"
  "${SIDX_SRC_DIR}/mvrtree/MVRTree.h"
  "${SIDX_SRC_DIR}/mvrtree/Node.cc"
  "${SIDX_SRC_DIR}/mvrtree/Node.h"
  "${SIDX_SRC_DIR}/mvrtree/PointerPoolNode.h"
  "${SIDX_SRC_DIR}/mvrtree/Statistics.cc"
  "${SIDX_SRC_DIR}/mvrtree/Statistics.h"
)
list (APPEND SIDX_CPP ${SIDX_MVRTREE_CPP})

set(SIDX_RTREE_CPP
  "${SIDX_SRC_DIR}/rtree/BulkLoader.cc"
  "${SIDX_SRC_DIR}/rtree/BulkLoader.h"
  "${SIDX_SRC_DIR}/rtree/Index.cc"
  "${SIDX_SRC_DIR}/rtree/Index.h"
  "${SIDX_SRC_DIR}/rtree/Leaf.cc"
  "${SIDX_SRC_DIR}/rtree/Leaf.h"
  "${SIDX_SRC_DIR}/rtree/Node.cc"
  "${SIDX_SRC_DIR}/rtree/Node.h"
  "${SIDX_SRC_DIR}/rtree/PointerPoolNode.h"
  "${SIDX_SRC_DIR}/rtree/RTree.cc"
  "${SIDX_SRC_DIR}/rtree/RTree.h"
  "${SIDX_SRC_DIR}/rtree/Statistics.cc"
  "${SIDX_SRC_DIR}/rtree/Statistics.h"
)
list (APPEND SIDX_CPP ${SIDX_RTREE_CPP})

set(SIDX_STORAGEMANAGER_CPP
  "${SIDX_SRC_DIR}/storagemanager/Buffer.cc"
  "${SIDX_SRC_DIR}/storagemanager/DiskStorageManager.cc"
  "${SIDX_SRC_DIR}/storagemanager/DiskStorageManager.h"
  "${SIDX_SRC_DIR}/storagemanager/MemoryStorageManager.cc"
  "${SIDX_SRC_DIR}/storagemanager/MemoryStorageManager.h"
  "${SIDX_SRC_DIR}/storagemanager/RandomEvictionsBuffer.cc"
  "${SIDX_SRC_DIR}/storagemanager/RandomEvictionsBuffer.h"
)
list (APPEND SIDX_CPP ${SIDX_STORAGEMANAGER_CPP})

set(SIDX_RAND48 )

if (NOT HAVE_SRAND48)
    set(SIDX_RAND48 "${SIDX_SRC_DIR}/tools/rand48.cc")
endif()

set(SIDX_TOOLS_CPP
  ${SIDX_RAND48}
  "${SIDX_SRC_DIR}/tools/Tools.cc"
)
list (APPEND SIDX_CPP ${SIDX_TOOLS_CPP})

set(SIDX_TOOLS_CPP
  "${SIDX_SRC_DIR}/tprtree/Index.cc"
  "${SIDX_SRC_DIR}/tprtree/Index.h"
  "${SIDX_SRC_DIR}/tprtree/Leaf.cc"
  "${SIDX_SRC_DIR}/tprtree/Leaf.h"
  "${SIDX_SRC_DIR}/tprtree/Node.cc"
  "${SIDX_SRC_DIR}/tprtree/Node.h"
  "${SIDX_SRC_DIR}/tprtree/PointerPoolNode.h"
  "${SIDX_SRC_DIR}/tprtree/Statistics.cc"
  "${SIDX_SRC_DIR}/tprtree/Statistics.h"
  "${SIDX_SRC_DIR}/tprtree/TPRTree.cc"
  "${SIDX_SRC_DIR}/tprtree/TPRTree.h"
)
list (APPEND SIDX_CPP ${SIDX_TOOLS_CPP} )
#
# Group source files for IDE source explorers (e.g. Visual Studio)
#

source_group("CMake Files" FILES CMakeLists.txt)

source_group("Header Files" FILES ${SIDX_BASE_HPP})
source_group("C API Header Files" FILES ${SIDX_CAPI_HPP})

source_group("Source Files" FILES ${SIDX_BASE_CPP})
source_group("C API Source Files" FILES ${SIDX_CAPI_CPP})


# Standard include directory of SIDX library
include_directories(../include)

set (APPS_CPP_DEPENDENCIES "${SIDX_LIB_NAME}" CACHE INTERNAL "libraries to link")

###############################################################################
# Targets settings

set(SIDX_SOURCES
  ${SIDX_HPP}
  ${SIDX_CPP})

# NOTE:
# This hack is required to correctly link static into shared library.
# Such practice is not recommended as not portable, instead each library,
# static and shared should be built from sources separately.
#if(UNIX)
#  add_definitions("-fPIC")
#endif()

if(WIN32)
  add_definitions("-DSIDX_DLL_EXPORT=1")
endif()

if(BUILD_SHARED_LIBS)
    add_library(${SIDX_LIB_NAME} SHARED ${SIDX_SOURCES})
    add_library(${SIDX_C_LIB_NAME} SHARED ${SIDX_CAPI_CPP})

    set_target_properties(${SIDX_LIB_NAME}
        PROPERTIES VERSION "${SIDX_LIB_VERSION}"
                   SOVERSION "${SIDX_LIB_SOVERSION}"  )

    set_target_properties(${SIDX_C_LIB_NAME}
        PROPERTIES VERSION "${SIDX_LIB_VERSION}"
                   SOVERSION "${SIDX_LIB_SOVERSION}" )
    set(INSTALL_INC_DIRS ${INSTALL_INC_DIR} PARENT_SCOPE)
elseif(OSX_FRAMEWORK)
    set_property(SOURCE ${SIDX_BASE_HPP} PROPERTY MACOSX_PACKAGE_LOCATION "Headers/spatialindex")
    add_library(${SIDX_LIB_NAME} SHARED ${SIDX_SOURCES} ${SIDX_BASE_HPP})

    set_target_properties(${SIDX_LIB_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION ${FRAMEWORK_VERSION}
        MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${VERSION}
        MACOSX_FRAMEWORK_BUNDLE_VERSION ${VERSION}
        MACOSX_FRAMEWORK_IDENTIFIER org.spatialindex.spatialindex
        XCODE_ATTRIBUTE_INSTALL_PATH "@rpath"
        # PUBLIC_HEADER "${SIDX_BASE_HPP}"
        VERSION ${SIDX_LIB_VERSION}
        SOVERSION ${SIDX_LIB_SOVERSION}
    )

    set(INSTALL_INC_DIRS ${INSTALL_LIB_DIR}/${SIDX_LIB_NAME}.framework/Headers)

    set_property(SOURCE ${SIDX_CAPI_HPP} PROPERTY MACOSX_PACKAGE_LOCATION "Headers/spatialindex/capi")
    add_library(${SIDX_C_LIB_NAME} SHARED ${SIDX_CAPI_CPP} ${SIDX_CAPI_HPP})
    set_target_properties(${SIDX_C_LIB_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION ${FRAMEWORK_VERSION}
        MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${VERSION}
        MACOSX_FRAMEWORK_BUNDLE_VERSION ${VERSION}
        MACOSX_FRAMEWORK_IDENTIFIER org.spatialindex.spatialindex_c
        XCODE_ATTRIBUTE_INSTALL_PATH "@rpath"
        # PUBLIC_HEADER "${SIDX_CAPI_HPP}"
        VERSION ${SIDX_LIB_VERSION}
        SOVERSION ${SIDX_LIB_SOVERSION}
    )

    set(INSTALL_INC_DIRS ${INSTALL_INC_DIRS} ${INSTALL_LIB_DIR}/${SIDX_C_LIB_NAME}.framework/Headers PARENT_SCOPE)
else()
    add_library(${SIDX_LIB_NAME} STATIC ${SIDX_SOURCES})
    add_library(${SIDX_C_LIB_NAME} STATIC ${SIDX_CAPI_CPP})
    set(INSTALL_INC_DIRS ${INSTALL_INC_DIR} PARENT_SCOPE)
endif()

target_link_libraries(${SIDX_C_LIB_NAME} ${SIDX_LIB_NAME} )

set_property(TARGET ${SIDX_LIB_NAME} APPEND PROPERTY
   INTERFACE_COMPILE_DEFINITIONS
       "SIDX_DLL_IMPORT=1" )
set_property(TARGET ${SIDX_C_LIB_NAME} APPEND PROPERTY
  INTERFACE_COMPILE_DEFINITIONS
      "SIDX_DLL_IMPORT=1" )

# Add path to includes to build-tree export
target_include_directories(${SIDX_LIB_NAME} INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_include_directories(${SIDX_C_LIB_NAME} INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

# Add all targets to the build-tree export set
export(TARGETS ${SIDX_LIB_NAME} ${SIDX_C_LIB_NAME}
    FILE ${PROJECT_BINARY_DIR}/${PACKAGE_UPPER_NAME}Targets.cmake)

###############################################################################
# Targets installation

if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
    install(TARGETS ${SIDX_LIB_NAME} ${SIDX_C_LIB_NAME}
        EXPORT ${PACKAGE_UPPER_NAME}Targets
        RUNTIME DESTINATION ${INSTALL_BIN_DIR}
        LIBRARY DESTINATION ${INSTALL_LIB_DIR}
        ARCHIVE DESTINATION ${INSTALL_LIB_DIR}
        INCLUDES DESTINATION ${INSTALL_INC_DIR}
        FRAMEWORK DESTINATION ${INSTALL_LIB_DIR}
    )
endif()

if(NOT SKIP_INSTALL_HEADERS AND NOT SKIP_INSTALL_ALL)
    install(DIRECTORY ${SIDX_HEADERS_DIR}
        #DESTINATION include/spatialindex
        DESTINATION ${INSTALL_INC_DIR}/${PROJECT_NAME}
        FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp")
endif()

if(OSX_FRAMEWORK)
    install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/spatialindex/tools
        DESTINATION ${INSTALL_LIB_DIR}/${SIDX_LIB_NAME}.framework/Headers
        FILES_MATCHING PATTERN "*.h")
endif()

if(NOT SKIP_INSTALL_LIBRARIES AND NOT SKIP_INSTALL_ALL)
    # Install the <Package>Config.cmake
    install(FILES
      ${PROJECT_BINARY_DIR}/${PACKAGE_UPPER_NAME}Config.cmake
      DESTINATION ${INSTALL_CMAKECONF_DIR} COMPONENT dev)

    # Install the export set for use with the install-tree
    install(EXPORT ${PACKAGE_UPPER_NAME}Targets DESTINATION ${INSTALL_CMAKECONF_DIR} COMPONENT dev)
endif()
