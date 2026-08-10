#include "stringop.hpp"

#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

std::vector<std::string> split(const std::string& str, const char delimiter) {
    std::vector<std::string> tokens;
    std::string token;
    for (char c : str) {
        if (c == delimiter) {
            if (!token.empty()) {
                tokens.push_back(token);
                token.clear();
            }
        } else {
            token += c;
        }
    }
    if (!token.empty()) {
        tokens.push_back(token);
    }
    return tokens;
}

int registerToInt(const std::string& reg) {
    if (reg.empty() || reg[0] != '$' || reg[0] != 'r') {
        std::cerr << "Invalid register format: " << reg << std::endl;
        std::abort();  // Terminate the program with an error
    }

    std::string regNumStr = reg.substr(1);  // Remove the '$' or 'r' prefix
    int regNum = std::stoi(regNumStr);      // Convert to integer

    if (regNum < 0 || regNum > 31) {
        std::cerr << "Register number out of range: " << regNum << std::endl;
        std::abort();  // Terminate the program with an error
    }

    return regNum;
}
