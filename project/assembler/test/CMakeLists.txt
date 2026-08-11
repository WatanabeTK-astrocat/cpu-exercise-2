message(STATUS "CMakeLists for test")

# ====== Google Test 関連のパッケージの導入 ======
# https://google.github.io/googletest/quickstart-cmake.html

message(STATUS "Fetching Google Test...")

FetchContent_Declare(
    googletest
    DOWNLOAD_EXTRACT_TIMESTAMP ON
    URL https://github.com/google/googletest/releases/download/v1.17.0/googletest-1.17.0.tar.gz # update occasionally
    FIND_PACKAGE_ARGS 
)

# For Windows: Prevent overriding the parent project's compiler/linker settings
# 親プロジェクトのコンパイラ・リンカ設定を上書きするのを防ぐ（Windowsのみ）
if(WIN32)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
endif()

FetchContent_MakeAvailable(googletest)

# ========== 単体テストの定義 ==========
add_executable(
    Test
    assembler_test.cpp
    stringop_test.cpp
)

# ========== ライブラリのリンク ==========
target_link_libraries(Test PRIVATE
    StaticStringOp
    StaticAssembler
    gtest_main
)

#configure_own_target(Test)

# ========== 単体テストの登録 ==========
include(GoogleTest)
gtest_discover_tests(
    Test
    PROPERTIES
    TIMEOUT 10
)
