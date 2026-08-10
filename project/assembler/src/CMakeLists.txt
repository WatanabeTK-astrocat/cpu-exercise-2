message(STATUS "CMakeLists for source")

# ==============================
# 実行ファイル

add_executable(
    assembler.out
    stringop.cpp
    assembler.cpp
    main.cpp
)

configure_own_target(assembler.out)
