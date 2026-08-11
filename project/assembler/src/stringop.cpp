#include "stringop.hpp"

#include <algorithm>
#include <regex>
#include <string>
#include <vector>

std::string preformattedString(const std::string& str) {
    const std::string commentsRemoved = std::regex_replace(str, std::regex("#.*"), "");              // Remove comments starting with '#'
    const std::string cleanedLine = std::regex_replace(commentsRemoved, std::regex("\\s+"), " ");    // Replace multiple spaces with a single space
    const std::string trimmedLine = std::regex_replace(cleanedLine, std::regex("^\\s+|\\s+$"), "");  // Trim leading and trailing spaces
    return trimmedLine;
}

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
