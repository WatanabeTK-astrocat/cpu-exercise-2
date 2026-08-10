message(STATUS "CMakeLists for source")

# ==============================
# 実行ファイル

add_executable(
    assembler.out
    main.cpp
    stringop.cpp
)

configure_own_target(assembler.out)
