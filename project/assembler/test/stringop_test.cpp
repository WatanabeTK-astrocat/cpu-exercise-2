#include "src/stringop.hpp"

#include <gtest/gtest.h>

#include <string>

namespace {
TEST(StringOpTest, PreformattedString_CommentsAndWhitespace) {
    const std::string input = "   add t0, t1, t2   # This is a comment   ";
    const std::string expectedOutput = "add t0, t1, t2";
    EXPECT_EQ(preformattedString(input), expectedOutput);
}

TEST(StringOpTest, Split1) {
    const std::string input = "add t0, t1, t2";
    const std::vector<std::string> expectedTokens = {"add", "t0,", "t1,", "t2"};
    EXPECT_EQ(split(input, ' '), expectedTokens);
}

TEST(StringOpTest, Split2) {
    const std::string input = "add t0,t1,t2";
    const std::vector<std::string> expectedTokens = {"add", "t0,t1,t2"};
    EXPECT_EQ(split(input, ' '), expectedTokens);
}

TEST(StringOpTest, BinaryStringToHexString) {
    const std::string binaryInput = "00000000101001100011100000100000";  // Binary representation of 'add t0, t1, t2' = 000000 00101 00110 00111 00000 100000
    const std::string expectedHexOutput = "00a63820";                    // Hexadecimal representation
    EXPECT_EQ(binaryStringToHexString(binaryInput), expectedHexOutput);
}
}  // namespace
