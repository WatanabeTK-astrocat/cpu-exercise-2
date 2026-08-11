#include "src/assembler.hpp"

#include <gtest/gtest.h>

#include <sstream>
#include <string>

#include "src/stringop.hpp"

namespace {
TEST(AssemblerTest, AddOp) {
    // Arrange
    std::stringstream buffer;
    buffer << "add t2,t0,t1\n";

    Assembler assembler;

    // Act
    std::string result = assembler.assemble(buffer);

    // Assert
    EXPECT_EQ(result, "00a63820\n");  // 00000000101001100011100000100000 // note the order of operands in the binary representation and \n
}
}  // namespace
