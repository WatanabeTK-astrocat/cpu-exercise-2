#include <fstream>
#include <iostream>
#include <regex>
#include <string>

#include "assembler.hpp"

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <input_file>" << std::endl;
        return 1;
    }

    std::ifstream inputFile(argv[1]);
    if (!inputFile) {
        std::cerr << "Error opening file: " << argv[1] << std::endl;
        return 1;
    }

    std::string line;
    while (std::getline(inputFile, line)) {
        // Process each line of the input file
        // std::cout << line << std::endl;  // For demonstration, just print the line
        const std::string cleanedLine = std::regex_replace(line, std::regex(",|\\s+"), " ");             // Replace commas and multiple spaces with a single space
        const std::string trimmedLine = std::regex_replace(cleanedLine, std::regex("^\\s+|\\s+$"), "");  // Trim leading and trailing spaces
        if (trimmedLine.empty()) {
            continue;  // Skip empty lines
        }
        const std::string binaryInstruction = assemble(trimmedLine);
        std::cout << binaryInstruction << std::endl;
    }

    inputFile.close();
    return 0;
}
