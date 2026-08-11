#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

#include "assembler.hpp"
#include "stringop.hpp"

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

    Assembler assembler;
    assembler.assemble(inputFile);
    inputFile.close();

    return 0;
}
