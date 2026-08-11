message(STATUS "CMakeLists for source")

# ==============================
# 静的ライブラリ

add_library(StaticStringOp STATIC
    stringop.cpp
)
configure_own_target(StaticStringOp)

add_library(StaticAssembler STATIC
    assembler.cpp
)
configure_own_target(StaticAssembler)

# ==============================
# 実行ファイル

add_executable(assembler.out main.cpp)

target_link_libraries(assembler.out PRIVATE
    StaticStringOp
    StaticAssembler
)

configure_own_target(assembler.out)

target_include_directories(assembler.out    PUBLIC ${PROJECT_SOURCE_DIR})
target_include_directories(StaticStringOp   PUBLIC ${PROJECT_SOURCE_DIR})
target_include_directories(StaticAssembler  PUBLIC ${PROJECT_SOURCE_DIR})
