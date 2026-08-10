#include <fstream>
#include <iostream>
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
        std::cout << line << std::endl;  // For demonstration, just print the line
    }

    inputFile.close();
    return 0;
}
