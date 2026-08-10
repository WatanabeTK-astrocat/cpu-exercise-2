#include "assembler.hpp"

#include <bitset>
#include <cassert>
#include <map>
#include <string>
#include <vector>

#include "stringop.hpp"

class RType_Nonshift_Opcode final {
   private:
    const int code;
    const int funct;

   public:
    explicit RType_Nonshift_Opcode(const int code, const int funct) : code(code), funct(funct) {}
    [[nodiscard]] std::string toBinaryString(const int rs, const int rt, const int rd) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<5> rsBits(rs);
        const std::bitset<5> rtBits(rt);
        const std::bitset<5> rdBits(rd);
        const std::bitset<5> shamtBits(0);  // Shift amount is 0 for non-shift instructions
        const std::bitset<6> functBits(funct);

        const std::string binaryString = opcodeBits.to_string() + rsBits.to_string() + rtBits.to_string() + rdBits.to_string() + shamtBits.to_string() + functBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryString;
    }
};

class RType_Shift_Opcode final {
   private:
    const int code;
    const int funct;

   public:
    explicit RType_Shift_Opcode(const int code, const int funct) : code(code), funct(funct) {}
    [[nodiscard]] std::string toBinaryString(const int rt, const int rd, const int shamt) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<5> rsBits(0);  // rs is 0 for shift instructions
        const std::bitset<5> rtBits(rt);
        const std::bitset<5> rdBits(rd);
        const std::bitset<5> shamtBits(shamt);
        const std::bitset<6> functBits(funct);

        const std::string binaryString = opcodeBits.to_string() + rsBits.to_string() + rtBits.to_string() + rdBits.to_string() + shamtBits.to_string() + functBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryString;
    }
};

class IType_Opcode final {
   private:
    const int code;

   public:
    explicit IType_Opcode(const int code) : code(code) {}
    [[nodiscard]] std::string toBinaryString(const int rs, const int rt, const int immediate) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<5> rsBits(rs);
        const std::bitset<5> rtBits(rt);
        const std::bitset<16> immediateBits(immediate);

        const std::string binaryString = opcodeBits.to_string() + rsBits.to_string() + rtBits.to_string() + immediateBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryString;
    }
};

class JType_Opcode final {
   private:
    const int code;

   public:
    explicit JType_Opcode(const int code) : code(code) {}
    [[nodiscard]] std::string toBinaryString(const int addr) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<26> addrBits(addr);

        const std::string binaryString = opcodeBits.to_string() + addrBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryString;
    }
};

class Assembler final {
   public:
    explicit Assembler() = default;
    ~Assembler() = default;

    [[nodiscard]] std::string assemble(const std::string& instruction) const {
        const std::vector<char> delimiters = {' ', '\t', ','};
        const std::vector<std::string> tokens = split(instruction, delimiters);
        if (tokens.empty()) {
            return "";  // Return an empty string for empty instructions
        }

        if (tokens[0] == "add") {
            // Example: add $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 32);  // Opcode for 'add' is 0, funct is 32
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "sub") {
            // Example: sub $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 34);  // Opcode for 'sub' is 0, funct is 34
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "addi") {
            // Example: addi $rt, $rs, immediate
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int immediate = std::stoi(tokens[3]);  // Convert immediate value to int
            IType_Opcode opcode(8);                      // Opcode for 'addi' is 8
            return opcode.toBinaryString(rs, rt, immediate);
        } else if (tokens[0] == "subi") {
            // Example: subi $rt, $rs, immediate
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int immediate = std::stoi(tokens[3]);  // Convert immediate value to int
            IType_Opcode opcode(9);                      // Opcode for 'subi' is 9
            return opcode.toBinaryString(rs, rt, immediate);
        } else if (tokens[0] == "and") {
            // Example: and $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 36);  // Opcode for 'and' is 0, funct is 36
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "or") {
            // Example: or $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 37);  // Opcode for 'or' is 0, funct is 37
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "xor") {
            // Example: xor $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 38);  // Opcode for 'xor' is 0, funct is 38
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "nor") {
            // Example: nor $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 39);  // Opcode for 'nor' is 0, funct is 39
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "andi") {
            // Example: andi $rt, $rs, immediate
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int immediate = std::stoi(tokens[3]);  // Convert immediate value to int
            IType_Opcode opcode(12);                     // Opcode for 'andi' is 12
            return opcode.toBinaryString(rs, rt, immediate);
        } else if (tokens[0] == "ori") {
            // Example: ori $rt, $rs, immediate
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int immediate = std::stoi(tokens[3]);  // Convert immediate value to int
            IType_Opcode opcode(13);                     // Opcode for 'ori' is 13
            return opcode.toBinaryString(rs, rt, immediate);
        } else if (tokens[0] == "xori") {
            // Example: xori $rt, $rs, immediate
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int immediate = std::stoi(tokens[3]);  // Convert immediate value to int
            IType_Opcode opcode(14);                     // Opcode for 'xori' is 14
            return opcode.toBinaryString(rs, rt, immediate);
        } else if (tokens[0] == "slt") {
            // Example: slt $rd, $rs, $rt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int rt = registerToInt(tokens[3]);
            RType_Nonshift_Opcode opcode(0, 42);  // Opcode for 'slt' is 0, funct is 42
            return opcode.toBinaryString(rs, rt, rd);
        } else if (tokens[0] == "slti") {
            // Example: slti $rt, $rs, immediate
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int immediate = std::stoi(tokens[3]);  // Convert immediate value to int
            IType_Opcode opcode(10);                     // Opcode for 'slti' is 10
            return opcode.toBinaryString(rs, rt, immediate);
        } else if (tokens[0] == "sll") {
            // Example: sll $rd, $rt, shamt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int shamt = std::stoi(tokens[3]);  // Convert shift amount to int
            RType_Shift_Opcode opcode(0, 0);         // Opcode for 'sll' is 0, funct is 0
            return opcode.toBinaryString(rt, rd, shamt);
        } else if (tokens[0] == "srl") {
            // Example: srl $rd, $rt, shamt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int shamt = std::stoi(tokens[3]);  // Convert shift amount to int
            RType_Shift_Opcode opcode(0, 2);         // Opcode for 'srl' is 0, funct is 2
            return opcode.toBinaryString(rt, rd, shamt);
        } else if (tokens[0] == "sra") {
            // Example: sra $rd, $rt, shamt
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rd = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int shamt = std::stoi(tokens[3]);  // Convert shift amount to int
            RType_Shift_Opcode opcode(0, 3);         // Opcode for 'sra' is 0, funct is 3
            return opcode.toBinaryString(rt, rd, shamt);
        } else if (tokens[0] == "lw") {
            // Example: lw $rt, $rs, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(35);                  // Opcode for 'lw' is 35
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "sw") {
            // Example: sw $rt, $rs, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(43);                  // Opcode for 'sw' is 43
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "lh") {
            // Example: lh $rt, $rs, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(33);                  // Opcode for 'lh' is 33
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "sh") {
            // Example: sh $rt, $rs, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(41);                  // Opcode for 'sh' is 41
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "lb") {
            // Example: lb $rt, $rs, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(32);                  // Opcode for 'lb' is 32
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "sb") {
            // Example: sb $rt, $rs, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rs = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(40);                  // Opcode for 'sb' is 40
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "lui") {
            // Example: lui $rt, immediate
            assert(tokens.size() == 3);                  // Ensure the instruction has the correct number of tokens
            const int rt = registerToInt(tokens[1]);     // Remove '$' and convert to int
            const int immediate = std::stoi(tokens[2]);  // Convert immediate value to int
            IType_Opcode opcode(15);                     // Opcode for 'lui' is 15
            return opcode.toBinaryString(0, rt, immediate);
        } else if (tokens[0] == "beq") {
            // Example: beq $rs, $rt, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(16);                  // Opcode for 'beq' is 16
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "bne") {
            // Example: bne $rs, $rt, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(17);                  // Opcode for 'bne' is 17
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "bge") {
            // Example: bge $rs, $rt, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(20);                  // Opcode for 'bge' is 20
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "bgt") {
            // Example: bgt $rs, $rt, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(23);                  // Opcode for 'bgt' is 23
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "ble") {
            // Example: ble $rs, $rt, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(22);                  // Opcode for 'ble' is 22
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "blt") {
            // Example: blt $rs, $rt, offset
            assert(tokens.size() == 4);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Remove '$' and convert to int
            const int rt = registerToInt(tokens[2]);
            const int offset = std::stoi(tokens[3]);  // Convert offset to int
            IType_Opcode opcode(21);                  // Opcode for 'blt' is 21
            return opcode.toBinaryString(rs, rt, offset);
        } else if (tokens[0] == "j") {
            // Example: j target
            assert(tokens.size() == 2);               // Ensure the instruction has the correct number of tokens
            const int target = std::stoi(tokens[1]);  // Convert target to int
            JType_Opcode opcode(2);                   // Opcode for 'j' is 2
            return opcode.toBinaryString(target);
        } else if (tokens[0] == "jal") {
            // Example: jal target
            assert(tokens.size() == 2);               // Ensure the instruction has the correct number of tokens
            const int target = std::stoi(tokens[1]);  // Convert target to int
            JType_Opcode opcode(3);                   // Opcode for 'jal' is 3
            return opcode.toBinaryString(target);
        } else if (tokens[0] == "jr") {
            // Example: jr $rs
            assert(tokens.size() == 2);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Convert target to int
            IType_Opcode opcode(2);                   // Opcode for 'jr' is 2
            return opcode.toBinaryString(rs, 0, 0);   // For 'jr', rt and immediate are not used
        } else if (tokens[0] == "jalr") {
            // Example: jalr $rs
            assert(tokens.size() == 2);               // Ensure the instruction has the correct number of tokens
            const int rs = registerToInt(tokens[1]);  // Convert target to int
            IType_Opcode opcode(3);                   // Opcode for 'jalr' is 3
            return opcode.toBinaryString(rs, 0, 0);   // For 'jalr', rt and immediate are not used
        } else {
            // Implement the logic to parse the tokens and generate the binary string
            // This is a placeholder implementation; you need to fill in the actual logic
            return "00000000000000000000000000000000";  // Placeholder binary string
        }
    }
};
