include_directories(../include)

if(MSVC_VERSION GREATER_EQUAL 1900)
   add_definitions(-D_SILENCE_TR1_NAMESPACE_DEPRECATION_WARNING)
endif()

include(FindAnyProject)
find_anyproject(GTest REQUIRED)

set (SOURCES
    gtest/test.h
    gtest/sidx_api_test.h
    gtest/main.cc 
)

set (TESTNAME libsidxtest)
add_executable(${TESTNAME} ${SOURCES})
target_link_libraries(${TESTNAME} ${SIDX_C_LIB_NAME} ${GTEST_LIBRARIES})

add_test(${TESTNAME} "${PROJECT_BINARY_DIR}/bin/${TESTNAME}" "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/..")

if(WIN32)
   add_custom_command(TARGET ${TESTNAME}
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -DDST_PATH="$<TARGET_FILE_DIR:${TESTNAME}>" -DSRC_PATH="${PROJECT_BINARY_DIR}" -P ${PROJECT_SOURCE_DIR}/cmake/test_dependency.cmake
      COMMENT "Copy DLLs"
   )
endif()