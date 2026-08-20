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

    std::stringstream buffer;
    buffer << inputFile.rdbuf();  // Read the entire file into the stringstream

    Assembler assembler;
    std::string res = assembler.assemble(buffer);
    std::cout << res;  // Print the assembled instructions
    inputFile.close();

    return 0;
}
