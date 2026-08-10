# ========== CMake Minimum Version ==========
cmake_minimum_required(VERSION 3.21)
# Refer to https://hsf-training.github.io/hsf-training-cmake-webpage/01-intro/index.html for which version to use
# 3.20 started support on NVHPC, 3.21 started support on HIP, 3.28 started support on modules


# ========== Project Definition ==========
message(STATUS "CMakeLists for project")

project(
    assembler_for_my_cpu # プロジェクト名
    VERSION 0.1 # バージョン
    LANGUAGES CXX # C++を使う
)


# ========== Require out-of-source builds ==========
# https://cliutils.gitlab.io/modern-cmake/chapters/basics/structure.html

file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory (i.e., build by out-of-source). Feel free to remove CMakeCache.txt and CMakeFiles.")
endif()


# ========== Only run if this is the main project ==========
# Ref: https://gitlab.com/CLIUtils/modern-cmake/tree/master/examples/extended-project
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    # ===== Set CMAKE_ Variables =====
    # Set only C++ Version. 
    #
    # 各コンパイラの対応しているC++のバージョン: 
    # nvcc(cuda): https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#c-language-support
    # 最近のバージョンについての一覧形式: https://en.cppreference.com/w/cpp/compiler_support
    # を参照のこと。これを見るとわかるように、2026/3現時点でC++26やC++23への対応は特にHPC(スパコン)用のコンパイラが遅れまくっている。
    # C++17では、C++ stdライブラリに科学計算用の特殊関数(e.g., ベッセル関数)が実装された。
    # KokkosライブラリはC++20を必須としている。
    # 以上のことから、C++20を使うこととする。
    set(CMAKE_CXX_STANDARD 20)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    # Let's ensure -std=c++xx instead of -std=g++xx
    set(CMAKE_CXX_EXTENSIONS ON)

    # See https://stackoverflow.com/questions/58628377/catalina-c-using-cmath-headers-yield-error-no-member-named-signbit-in-th
    #set(CMAKE_OSX_SYSROOT /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk)

    # Let's nicely support folders in IDEs
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    # Testing only available if this is the main app
    # Note this needs to be done in the main CMakeLists
    # since it calls enable_testing, which must be in the
    # main CMakeLists.
    include(CTest)

    # Docs only available if this is the main app
    find_package(Doxygen)
    if(Doxygen_FOUND)
    #    add_subdirectory(doxygen)
    else()
        message(STATUS "Doxygen not found, not building doxygen docs")
    endif()

    # Export compile_commands.json for clangd and other tools
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()


# ========== Include FetchContent ==========
# FetchContent added in CMake 3.11, downloads during the configure step
# FetchContent_MakeAvailable was added in CMake 3.14; simpler usage
include(FetchContent)


# ========== Set build type if not specified ==========
# https://www.kitware.com/cmake-and-the-default-build-type/

set(default_build_type "Release")

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
        STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Release" "RelWithDebInfo" "Debug" )
endif()


# ========== Define Compiler/Linker Flag Function ==========
# ==== Optimizations ====
# -O0, -O1, -O2, -O3
# -Ofast: -ffastmath -fallow-store-data-races -fstack-arrays -fno-protect-parens -fno-semantic-interposition
# -ffast-math: -fno-math-errno -funsafe-math-optimizations -ffinite-math-only -fno-rounding-math -fno-signaling-nans -fcx-limited-range -fexcess-precision=fast
# -march=native: compile exculusively for native (host) architecture. See also: -mtune -mcpu [2]
# 
# See:
# https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
# https://wiki.gentoo.org/wiki/GCC_optimization/
#
# ==== Warnings and Errors ====
# -Wall: Warn all
# -Wextra: Warn extra
# -Wfatal-errors: Stop compiling on the first errors
# -g: Enable core dump
# 
# See:
# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# https://qiita.com/EqualL2/items/0cfb5b1cbfd70e2af662
# https://triple-four.hatenablog.com/entry/20210623/1624458051
#

function(configure_own_target target)
    # Private Compile Options
    target_compile_options(${target} PRIVATE
        $<$<CONFIG:Release>:-O3>
        #$<$<CONFIG:Release>:-fno-math-errno -ffinite-math-only -fno-signed-zeros>
        $<$<CONFIG:Release>:-march=native>
        $<$<CONFIG:RelWithDebInfo>:-O3>
        #$<$<CONFIG:RelWithDebInfo>:-fno-math-errno -ffinite-math-only -fno-signed-zeros>
        $<$<CONFIG:RelWithDebInfo>:-march=native>
        $<$<CONFIG:Debug>:-O0>
        $<$<CXX_COMPILER_ID:GNU,AppleClang,Clang>: -Wall -Wextra>
        $<$<CXX_COMPILER_ID:GNU,AppleClang,Clang>: -Wdate-time>
        #-Weffc++　-Wcast-align -Wconversion -Wredundant-decls -Wreorder -Wswitch-default -Wswitch-enum
        $<$<CXX_COMPILER_ID:MSVC>: /W4>
    )
    
    # Link-Time Optimization (LTO) (-flto=auto)
    set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION_RELEASE TRUE)
    set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO TRUE)

    # Sanitizer not supported on macOS GCC. See: https://github.com/orgs/Homebrew/discussions/3384#discussioncomment-6264292
    target_compile_options(${target} PUBLIC
              $<$<CONFIG:RelWithDebInfo>: -g -gdwarf-4 -gstrict-dwarf>
        $<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:AppleClang,Clang>>: -fsanitize=undefined,address>
              $<$<CONFIG:Debug>: -g -gdwarf-4 -gstrict-dwarf>
        $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:AppleClang,Clang>>: -fsanitize=undefined,address>
              $<$<CONFIG:Debug>: -fno-omit-frame-pointer>
    )
    target_link_options(${target} PUBLIC
        $<$<AND:$<CONFIG:RelWithDebInfo>,$<CXX_COMPILER_ID:AppleClang,Clang>>: -fsanitize=undefined,address>
        $<$<AND:$<CONFIG:Debug>,$<CXX_COMPILER_ID:AppleClang,Clang>>: -fsanitize=undefined,address>
              $<$<CONFIG:Debug>: -fno-omit-frame-pointer>
    )
endfunction()


# Force Clang to use g++ standard library
# This project uses bessel functions, which was added to C++17 library feature, but clang standard library does not implement them even in 2026.
# See:
# https://en.cppreference.com/w/cpp/compiler_support/17.html#C.2B.2B17_library_features
# https://www.reddit.com/r/cpp/comments/1bt1lne/mathematical_special_functions_in_libc/
# However, this hotfix does not work......
# Maybe: https://www.reddit.com/r/cpp_questions/comments/1c6bm62/using_libstdc_with_clang_on_arm_macs/?show=original
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
endif()


# ========== Subdirectories ==========
# source directory
add_subdirectory(src)

# Testing only available if this is the main app
# Emergency override MODERN_CMAKE_BUILD_TESTING provided as well
if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME OR MODERN_CMAKE_BUILD_TESTING) AND BUILD_TESTING)
    add_subdirectory(test)
endif()
