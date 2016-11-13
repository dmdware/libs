if("master" STREQUAL "")
  message(FATAL_ERROR "Tag for git checkout should not be empty.")
endif()

set(run 0)

if("F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest-stamp/gtest-gitinfo.txt" IS_NEWER_THAN "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest-stamp/gtest-gitclone-lastrun.txt")
  set(run 1)
endif()

if(NOT run)
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: 'F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest-stamp/gtest-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E remove_directory "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: 'F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest'")
endif()

# try the clone 3 times incase there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "C:/Program Files/Git/cmd/git.exe" clone "https://chromium.googlesource.com/external/googletest" "gtest"
    WORKING_DIRECTORY "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://chromium.googlesource.com/external/googletest'")
endif()

execute_process(
  COMMAND "C:/Program Files/Git/cmd/git.exe" checkout master
  WORKING_DIRECTORY "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'master'")
endif()

execute_process(
  COMMAND "C:/Program Files/Git/cmd/git.exe" submodule init
  WORKING_DIRECTORY "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to init submodules in: 'F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest'")
endif()

execute_process(
  COMMAND "C:/Program Files/Git/cmd/git.exe" submodule update --recursive 
  WORKING_DIRECTORY "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: 'F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest-stamp/gtest-gitinfo.txt"
    "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest-stamp/gtest-gitclone-lastrun.txt"
  WORKING_DIRECTORY "F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: 'F:/proj/libs/win/assimp-3.2/assimp-3.2/buildvc9/test/gtest/src/gtest-stamp/gtest-gitclone-lastrun.txt'")
endif()

