#include "assembler.hpp"

#include <bitset>
#include <cassert>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <tuple>
#include <vector>

#include "stringop.hpp"

int registerToInt(const std::string& reg) {
    std::cout << "reg :" << reg << std::endl;
    if (reg == "zero") {
        return 0;  // Special case for the zero register
    } else if (reg == "t3") {
        return 1;  // Special case for temporary register t3
    } else if (reg == "sp") {
        return 2;  // Special case for the stack pointer register
    } else if (reg == "gp") {
        return 3;  // Special case for the global pointer register
    } else if (reg == "tp") {
        return 4;  // Special case for the thread pointer register
    } else if (reg == "t0") {
        return 5;  // Special case for temporary register t0
    } else if (reg == "t1") {
        return 6;  // Special case for temporary register t1
    } else if (reg == "t2") {
        return 7;  // Special case for temporary register t2
    } else if (reg == "s0" || reg == "fp") {
        return 8;  // Special case for saved register s0
    } else if (reg == "s1") {
        return 9;  // Special case for saved register s1
    } else if (reg == "a0") {
        return 10;  // Special case for argument register a0
    } else if (reg == "a1") {
        return 11;  // Special case for argument register a1
    } else if (reg == "a2") {
        return 12;  // Special case for argument register a2
    } else if (reg == "a3") {
        return 13;  // Special case for argument register a3
    } else if (reg == "a4") {
        return 14;  // Special case for argument register a4
    } else if (reg == "a5") {
        return 15;  // Special case for argument register a5
    } else if (reg == "a6") {
        return 16;  // Special case for argument register a6
    } else if (reg == "a7") {
        return 17;  // Special case for argument register a7
    } else if (reg == "s2") {
        return 18;  // Special case for saved register s2
    } else if (reg == "s3") {
        return 19;  // Special case for saved register s3
    } else if (reg == "s4") {
        return 20;  // Special case for saved register s4
    } else if (reg == "s5") {
        return 21;  // Special case for saved register s5
    } else if (reg == "s6") {
        return 22;  // Special case for saved register s6
    } else if (reg == "s7") {
        return 23;  // Special case for saved register s7
    } else if (reg == "s8") {
        return 24;  // Special case for saved register s8
    } else if (reg == "s9") {
        return 25;  // Special case for saved register s9
    } else if (reg == "s10") {
        return 26;  // Special case for saved register s10
    } else if (reg == "s11") {
        return 27;  // Special case for saved register s11
    } else if (reg == "t4") {
        return 28;  // Special case for temporary register t4
    } else if (reg == "t5") {
        return 29;  // Special case for temporary register t5
    } else if (reg == "t6") {
        return 30;  // Special case for temporary register t6
    } else if (reg == "ra") {
        return 31;  // Special case for the return address register
    }

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

class RType_Nonshift_Opcode final {
   private:
    const int code;
    const int funct;

   public:
    explicit RType_Nonshift_Opcode(const int code, const int funct) : code(code), funct(funct) {}
    [[nodiscard]] std::string toHexString(const int rs, const int rt, const int rd) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<5> rsBits(rs);
        const std::bitset<5> rtBits(rt);
        const std::bitset<5> rdBits(rd);
        const std::bitset<5> shamtBits(0);  // Shift amount is 0 for non-shift instructions
        const std::bitset<6> functBits(funct);

        const std::string binaryString = opcodeBits.to_string() + rsBits.to_string() + rtBits.to_string() + rdBits.to_string() + shamtBits.to_string() + functBits.to_string();
        return binaryStringToHexString(binaryString);
    }
};

class RType_Shift_Opcode final {
   private:
    const int code;
    const int funct;

   public:
    explicit RType_Shift_Opcode(const int code, const int funct) : code(code), funct(funct) {}
    [[nodiscard]] std::string toHexString(const int rt, const int rd, const int shamt) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<5> rsBits(0);  // rs is 0 for shift instructions
        const std::bitset<5> rtBits(rt);
        const std::bitset<5> rdBits(rd);
        const std::bitset<5> shamtBits(shamt);
        const std::bitset<6> functBits(funct);

        const std::string binaryString = opcodeBits.to_string() + rsBits.to_string() + rtBits.to_string() + rdBits.to_string() + shamtBits.to_string() + functBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryStringToHexString(binaryString);
    }
};

class IType_Opcode final {
   private:
    const int code;

   public:
    explicit IType_Opcode(const int code) : code(code) {}
    [[nodiscard]] std::string toHexString(const int rs, const int rt, const int immediate) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<5> rsBits(rs);
        const std::bitset<5> rtBits(rt);
        const std::bitset<16> immediateBits(immediate);

        const std::string binaryString = opcodeBits.to_string() + rsBits.to_string() + rtBits.to_string() + immediateBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryStringToHexString(binaryString);
    }
};

class JType_Opcode final {
   private:
    const int code;

   public:
    explicit JType_Opcode(const int code) : code(code) {}
    [[nodiscard]] std::string toHexString(const int addr) const {
        const std::bitset<6> opcodeBits(code);
        const std::bitset<26> addrBits(addr);

        const std::string binaryString = opcodeBits.to_string() + addrBits.to_string();
        assert(binaryString.length() == 32);  // Ensure the binary string is 32 bits long
        return binaryStringToHexString(binaryString);
    }
};

[[nodiscard]] int Assembler::labelToAbsoluteAddress(const std::string& label) const {
    return labels.at(label);  // Use .at() to throw an exception if the label is not found
}

[[nodiscard]] int Assembler::labelToDpl(const std::string& label, const int addressnow) const {
    const int labelAddress = labelToAbsoluteAddress(label);
    return labelAddress - addressnow;  // Calculate the DPL (distance in program lines) from the current address
}

[[nodiscard]] std::tuple<bool, std::string>
Assembler::assemble_line_first_pass(const std::string& instruction, const int addressnow) {
    const std::vector<std::string> tokens = split(instruction);
    if (tokens.empty()) {
        return std::make_tuple(false, "");  // Return an empty string for empty instructions
    } else if (tokens[0].at(0) == '.' && tokens[0].back() != ':') {
        return std::make_tuple(false, "");  // Return an empty string for comment lines
    } else if (tokens[0] == "nop") {
        return std::make_tuple(false, std::string(32, '0'));  // Return 32 zeros for NOP
    } else if (tokens[0].back() == ':') {
        const std::string label = tokens[0].substr(0, tokens[0].length() - 1);  // Remove the colon from the label
        labels[label] = addressnow;                                             // Store the label with its absolute address
        return std::make_tuple(true, "");
    }
    return std::make_tuple(false, std::string(32, '0'));
}

[[nodiscard]] std::tuple<int, int, int> Assembler::decompose_Rtype_nonshift_operands(const std::string& operands_concat) const {
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 3);  // Ensure there are exactly 3 operands for R-type non-shift instructions
    return std::make_tuple(registerToInt(operands[0]), registerToInt(operands[1]), registerToInt(operands[2]));
}

[[nodiscard]] std::tuple<int, int, int> Assembler::decompose_Rtype_shift_operands(const std::string& operands_concat) const {
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 3);  // Ensure there are exactly 3 operands for R-type shift instructions
    return std::make_tuple(registerToInt(operands[0]), registerToInt(operands[1]), std::stoi(operands[2]));
}

[[nodiscard]] std::tuple<int, int, int> Assembler::decompose_Itype_operands(const std::string& operands_concat) const {
    // It's actually the same as Rtype shift operands, but we keep it separate for clarity and potential future changes
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 3);  // Ensure there are exactly 3 operands for I-type instructions
    return std::make_tuple(registerToInt(operands[0]), registerToInt(operands[1]), std::stoi(operands[2]));
}

[[nodiscard]] std::tuple<int, int, int> Assembler::decompose_Itype_memory_operands(const std::string& operands_concat) const {
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 2);  // Ensure there are exactly 2 operands by comma for I-type memory instructions
    const std::vector<std::string> offset_and_register = split(operands[1], '(');
    assert(offset_and_register.size() == 2);  // Ensure the second operand is in the form offset($rs)
    const int rt = registerToInt(operands[0]);
    const int offset = std::stoi(offset_and_register[0]);                                                 // Convert offset to int
    const int rs = registerToInt(offset_and_register[1].substr(0, offset_and_register[1].length() - 1));  // Remove the closing parenthesis and convert to int
    return std::make_tuple(rt, rs, offset);
}

[[nodiscard]] std::tuple<int, int, int> Assembler::decompose_branch_operands(const std::string& operands_concat, const int addressnow) const {
    // It's actually the same as Rtype shift operands, but we keep it separate for clarity and potential future changes
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 3);  // Ensure there are exactly 3 operands for I-type instructions
    return std::make_tuple(registerToInt(operands[0]), registerToInt(operands[1]), labelToDpl(operands[2], addressnow));
}

[[nodiscard]] std::tuple<int, int> Assembler::decompose_Itype_lui_operands(const std::string& operands_concat) const {
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 2);  // Ensure there are exactly 2 operands for I-type instructions
    return std::make_tuple(registerToInt(operands[0]), std::stoi(operands[1]));
}

[[nodiscard]] std::tuple<int, int> Assembler::decompose_mv_operands(const std::string& operands_concat) const {
    const std::vector<std::string> operands = split(operands_concat, ',');
    assert(operands.size() == 2);  // Ensure there are exactly 2 operands for I-type instructions
    return std::make_tuple(registerToInt(operands[0]), registerToInt(operands[1]));
}

[[nodiscard]] std::tuple<bool, std::string>
Assembler::assemble_line_second_pass(const std::string& instruction, const int addressnow) const {
    const std::vector<std::string> tokens = split(instruction);
    bool wasLabel = false;
    if (tokens.empty()) {
        return std::make_tuple(wasLabel, "");  // Return an empty string for empty instructions
    } else if (tokens[0].at(0) == '.' && tokens[0].back() != ':') {
        return std::make_tuple(wasLabel, "");  // Return an empty string for comment lines
    } else if (tokens[0] == "nop") {
        return std::make_tuple(wasLabel, std::string(32, '0'));  // Return 32 zeros for NOP
    } else if (tokens[0] == "add") {
        // Example: add $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 32);                                     // Opcode for 'add' is 0, funct is 32
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "sub") {
        // Example: sub $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 34);                                     // Opcode for 'sub' is 0, funct is 34
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "addi") {
        // Example: addi $rt, $rs, immediate
        assert(tokens.size() == 2);                                            // Ensure the instruction has the correct number of tokens
        const auto [rt, rs, immediate] = decompose_Itype_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(8);                                                // Opcode for 'addi' is 8
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, immediate));
    } else if (tokens[0] == "subi") {
        // Example: subi $rt, $rs, immediate
        assert(tokens.size() == 2);                                            // Ensure the instruction has the correct number of tokens
        const auto [rt, rs, immediate] = decompose_Itype_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(9);                                                // Opcode for 'subi' is 9
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, immediate));
    } else if (tokens[0] == "and") {
        // Example: and $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 36);                                     // Opcode for 'and' is 0, funct is 36
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "or") {
        // Example: or $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 37);                                     // Opcode for 'or' is 0, funct is 37
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "xor") {
        // Example: xor $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 38);                                     // Opcode for 'xor' is 0, funct is 38
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "nor") {
        // Example: nor $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 39);                                     // Opcode for 'nor' is 0, funct is 39
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "andi") {
        // Example: andi $rt, $rs, immediate
        assert(tokens.size() == 2);                                            // Ensure the instruction has the correct number of tokens
        const auto [rt, rs, immediate] = decompose_Itype_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(12);                                               // Opcode for 'andi' is 12
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, immediate));
    } else if (tokens[0] == "ori") {
        // Example: ori $rt, $rs, immediate
        assert(tokens.size() == 2);                                            // Ensure the instruction has the correct number of tokens
        const auto [rt, rs, immediate] = decompose_Itype_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(13);                                               // Opcode for 'ori' is 13
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, immediate));
    } else if (tokens[0] == "xori") {
        // Example: xori $rt, $rs, immediate
        assert(tokens.size() == 2);                                            // Ensure the instruction has the correct number of tokens
        const auto [rt, rs, immediate] = decompose_Itype_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(14);                                               // Opcode for 'xori' is 14
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, immediate));
    } else if (tokens[0] == "slt") {
        // Example: slt $rd, $rs, $rt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rs, rt] = decompose_Rtype_nonshift_operands(tokens[1]);  // Decompose operands into rd, rs, rt
        RType_Nonshift_Opcode opcode(0, 42);                                     // Opcode for 'slt' is 0, funct is 42
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, rd));
    } else if (tokens[0] == "slti") {
        // Example: slti $rt, $rs, immediate
        assert(tokens.size() == 2);                                            // Ensure the instruction has the correct number of tokens
        const auto [rt, rs, immediate] = decompose_Itype_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(10);                                               // Opcode for 'slti' is 10
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, immediate));
    } else if (tokens[0] == "slli") {
        // Example: slli $rd, $rt, shamt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rt, shamt] = decompose_Rtype_shift_operands(tokens[1]);  // Decompose operands into rd, rt, shamt
        RType_Shift_Opcode opcode(0, 0);                                         // Opcode for 'slli' is 0, funct is 0
        return std::make_tuple(wasLabel, opcode.toHexString(rt, rd, shamt));
    } else if (tokens[0] == "srli") {
        // Example: srli $rd, $rt, shamt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rt, shamt] = decompose_Rtype_shift_operands(tokens[1]);  // Decompose operands into rd, rt, shamt
        RType_Shift_Opcode opcode(0, 2);                                         // Opcode for 'srli' is 0, funct is 2
        return std::make_tuple(wasLabel, opcode.toHexString(rt, rd, shamt));
    } else if (tokens[0] == "srai") {
        // Example: srai $rd, $rt, shamt
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rd, rt, shamt] = decompose_Rtype_shift_operands(tokens[1]);  // Decompose operands into rd, rt, shamt
        RType_Shift_Opcode opcode(0, 3);                                         // Opcode for 'srai' is 0, funct is 3
        return std::make_tuple(wasLabel, opcode.toHexString(rt, rd, shamt));
    } else if (tokens[0] == "lw") {
        // Example: lw $rt, $rs, offset
        assert(tokens.size() == 2);                                                // Ensure the instruction has the correct number of tokens
        const auto [rt, offset, rs] = decompose_Itype_memory_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(35);                                                   // Opcode for 'lw' is 35
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "sw") {
        // Example: sw $rt, $rs, offset
        assert(tokens.size() == 2);                                                // Ensure the instruction has the correct number of tokens
        const auto [rt, offset, rs] = decompose_Itype_memory_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(43);                                                   // Opcode for 'sw' is 43
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "lh") {
        // Example: lh $rt, $rs, offset
        assert(tokens.size() == 2);                                                // Ensure the instruction has the correct number of tokens
        const auto [rt, offset, rs] = decompose_Itype_memory_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(33);                                                   // Opcode for 'lh' is 33
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "sh") {
        // Example: sh $rt, $rs, offset
        assert(tokens.size() == 2);                                                // Ensure the instruction has the correct number of tokens
        const auto [rt, offset, rs] = decompose_Itype_memory_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(41);                                                   // Opcode for 'sh' is 41
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "lb") {
        // Example: lb $rt, $rs, offset
        assert(tokens.size() == 2);                                                // Ensure the instruction has the correct number of tokens
        const auto [rt, offset, rs] = decompose_Itype_memory_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(32);                                                   // Opcode for 'lb' is 32
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "sb") {
        // Example: sb $rt, $rs, offset
        assert(tokens.size() == 2);                                                // Ensure the instruction has the correct number of tokens
        const auto [rt, offset, rs] = decompose_Itype_memory_operands(tokens[1]);  // Decompose operands into rt, rs, immediate
        IType_Opcode opcode(40);                                                   // Opcode for 'sb' is 40
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "lui") {
        // Example: lui $rt, immediate
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rt, immediate] = decompose_Itype_lui_operands(tokens[1]);    // Decompose operands into rt and immediate
        IType_Opcode opcode(15);                                                 // Opcode for 'lui' is 15
        return std::make_tuple(wasLabel, opcode.toHexString(0, rt, immediate));  // rs is 0 for 'lui'
    } else if (tokens[0] == "beq") {
        // Example: beq $rs, $rt, offset
        assert(tokens.size() == 2);                                                      // Ensure the instruction has the correct number of tokens
        const auto [rs, rt, offset] = decompose_branch_operands(tokens[1], addressnow);  // Decompose operands into rs, rt, offset
        IType_Opcode opcode(16);                                                         // Opcode for 'beq' is 16
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "bne") {
        // Example: bne $rs, $rt, offset
        assert(tokens.size() == 2);                                                      // Ensure the instruction has the correct number of tokens
        const auto [rs, rt, offset] = decompose_branch_operands(tokens[1], addressnow);  // Decompose operands into rs, rt, offset
        IType_Opcode opcode(17);                                                         // Opcode for 'bne' is 17
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "bge") {
        // Example: bge $rs, $rt, offset
        assert(tokens.size() == 2);                                                      // Ensure the instruction has the correct number of tokens
        const auto [rs, rt, offset] = decompose_branch_operands(tokens[1], addressnow);  // Decompose operands into rs, rt, offset
        IType_Opcode opcode(20);                                                         // Opcode for 'bge' is 20
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "bgt") {
        // Example: bgt $rs, $rt, offset
        assert(tokens.size() == 2);                                                      // Ensure the instruction has the correct number of tokens
        const auto [rs, rt, offset] = decompose_branch_operands(tokens[1], addressnow);  // Decompose operands into rs, rt, offset
        IType_Opcode opcode(23);                                                         // Opcode for 'bgt' is 23
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "ble") {
        // Example: ble $rs, $rt, offset
        assert(tokens.size() == 2);                                                      // Ensure the instruction has the correct number of tokens
        const auto [rs, rt, offset] = decompose_branch_operands(tokens[1], addressnow);  // Decompose operands into rs, rt, offset
        IType_Opcode opcode(22);                                                         // Opcode for 'ble' is 22
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "blt") {
        // Example: blt $rs, $rt, offset
        assert(tokens.size() == 2);                                                      // Ensure the instruction has the correct number of tokens
        const auto [rs, rt, offset] = decompose_branch_operands(tokens[1], addressnow);  // Decompose operands into rs, rt, offset
        IType_Opcode opcode(21);                                                         // Opcode for 'blt' is 21
        return std::make_tuple(wasLabel, opcode.toHexString(rs, rt, offset));
    } else if (tokens[0] == "j") {
        // Example: j target
        assert(tokens.size() == 2);                            // Ensure the instruction has the correct number of tokens
        const int target = labelToAbsoluteAddress(tokens[1]);  // Convert target to int
        JType_Opcode opcode(2);                                // Opcode for 'j' is 2
        return std::make_tuple(wasLabel, opcode.toHexString(target));
    } else if (tokens[0] == "jal") {
        // Example: jal target
        assert(tokens.size() == 2);                            // Ensure the instruction has the correct number of tokens
        const int target = labelToAbsoluteAddress(tokens[1]);  // Convert target to int
        JType_Opcode opcode(3);                                // Opcode for 'jal' is 3
        return std::make_tuple(wasLabel, opcode.toHexString(target));
    } else if (tokens[0] == "jr") {
        // Example: jr $rs
        assert(tokens.size() == 2);                                      // Ensure the instruction has the correct number of tokens
        const int rs = registerToInt(tokens[1]);                         // Convert target to int
        IType_Opcode opcode(2);                                          // Opcode for 'jr' is 2
        return std::make_tuple(wasLabel, opcode.toHexString(rs, 0, 0));  // For 'jr', rt and immediate are not used
    } else if (tokens[0] == "jalr") {
        // Example: jalr $rs
        assert(tokens.size() == 2);                                      // Ensure the instruction has the correct number of tokens
        const int rs = registerToInt(tokens[1]);                         // Convert target to int
        IType_Opcode opcode(3);                                          // Opcode for 'jalr' is 3
        return std::make_tuple(wasLabel, opcode.toHexString(rs, 0, 0));  // For 'jalr', rt and immediate are not used
    } else if (tokens[0] == "li") {
        // Example: li $rt, immediate
        // this is a pseudo-instruction that can be translated to 'addi $rt, $zero, immediate'
        assert(tokens.size() == 2);                                              // Ensure the instruction has the correct number of tokens
        const auto [rt, immediate] = decompose_Itype_lui_operands(tokens[1]);    // Decompose operands into rt and immediate
        IType_Opcode opcode(8);                                                  // Opcode for 'li' is 8 (same as 'addi')
        return std::make_tuple(wasLabel, opcode.toHexString(0, rt, immediate));  // For 'li', rs is 0
    } else if (tokens[0] == "mv" || tokens[0] == "move") {
        // Example: mv $rd, $rs
        // this is a pseudo-instruction that can be translated to 'add $rd, $rs, $zero'
        assert(tokens.size() == 2);                                       // Ensure the instruction has the correct number of tokens
        const auto [rd, rs] = decompose_mv_operands(tokens[1]);           // Decompose operands into rd and rs
        RType_Nonshift_Opcode opcode(0, 32);                              // Opcode for 'add' is 0, funct is 32
        return std::make_tuple(wasLabel, opcode.toHexString(rs, 0, rd));  // For 'mv', rt is 0
    } else if (tokens[0] == "ret") {
        // Example: ret
        // this is a pseudo-instruction that can be translated to 'jr $ra'
        assert(tokens.size() == 1);                                      // Ensure the instruction has the correct number of tokens
        const int rs = 31;                                               // $ra is register 31
        IType_Opcode opcode(2);                                          // Opcode for 'jr' is 2
        return std::make_tuple(wasLabel, opcode.toHexString(rs, 0, 0));  // For 'ret', rt and immediate are not used
    } else if (tokens[0] == "call") {
        // Example: call target
        // this is a pseudo-instruction that can be translated to 'jal target'
        assert(tokens.size() == 2);                            // Ensure the instruction has the correct number of tokens
        const int target = labelToAbsoluteAddress(tokens[1]);  // Convert target to int
        JType_Opcode opcode(3);                                // Opcode for 'jal' is 3
        return std::make_tuple(wasLabel, opcode.toHexString(target));
    } else if (tokens[0].back() == ':') {
        // This is a label, we can ignore it in the second pass
        wasLabel = true;
        return std::make_tuple(wasLabel, "");  // Return an empty string for labels
    } else {
        std::cerr << "Unknown instruction: " << tokens[0] << std::endl;
        std::abort();  // Terminate the program with an error
    }
}

void rewind_to_beginning(std::stringstream& in) {
    // EOF以外の読み取り失敗を、clear()で隠す前に検出する
    if (in.bad() || (in.fail() && !in.eof())) {
        std::cerr << "failed to read source" << std::endl;
        std::abort();  // Terminate the program with an error
    }

    // getline()でEOFまで読んだ後は、通常eofbitとfailbitが立っている
    in.clear();
    in.seekg(0, std::ios::beg);

    if (!in) {
        std::cerr << "failed to rewind source" << std::endl;
        std::abort();  // Terminate the program with an error
    }
}

std::string Assembler::assemble(std::stringstream& inputFile) {
    std::string line;
    int addressnow = 0;  // Initialize the current address to 0
    while (std::getline(inputFile, line)) {
        // Process each line of the input file
        // std::cout << line << std::endl;  // For demonstration, just print the line

        const std::string cleanLine = preformattedString(line);
        if (cleanLine.empty()) {
            continue;  // Skip empty lines
        }
        const auto [wasLabel, binaryInstruction] = assemble_line_first_pass(cleanLine, addressnow);
        if (!wasLabel && !binaryInstruction.empty()) {
            // Only increment the address if the line was not a label
            addressnow += 4;  // Increment the address by 4 (size of a word)
        }
    }

    rewind_to_beginning(inputFile);

    addressnow = 0;  // Initialize the current address to 0
    std::string result;
    while (std::getline(inputFile, line)) {
        // Process each line of the input file
        // std::cout << line << std::endl;  // For demonstration, just print the line

        const std::string cleanLine = preformattedString(line);
        if (cleanLine.empty()) {
            continue;  // Skip empty lines
        }
        const auto [wasLabel, binaryInstruction] = assemble_line_second_pass(cleanLine, addressnow);
        if (!wasLabel && !binaryInstruction.empty()) {
            // Only increment the address if the line was not a label
            result += binaryInstruction + "\n";  // Append the binary instruction
            addressnow += 4;                     // Increment the address by 4 (size of a word)
        }
    }

    return result;
}
