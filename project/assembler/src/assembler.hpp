#include <map>
#include <sstream>
#include <string>
#include <tuple>

class Assembler final {
   private:
    std::map<std::string, int> labels;  // Map to store labels and their corresponding addresses>

    [[nodiscard]] int labelToAbsoluteAddress(const std::string& label) const;
    [[nodiscard]] int labelToDpl(const std::string& label, const int addressnow) const;

    [[nodiscard]] std::tuple<int, int, int> decompose_Rtype_nonshift_operands(const std::string& operands_concat) const;
    [[nodiscard]] std::tuple<int, int, int> decompose_Rtype_shift_operands(const std::string& operands_concat) const;
    [[nodiscard]] std::tuple<int, int, int> decompose_Itype_operands(const std::string& operands_concat) const;
    [[nodiscard]] std::tuple<int, int, int> decompose_Itype_memory_operands(const std::string& operands_concat) const;
    [[nodiscard]] std::tuple<int, int, int> decompose_branch_operands(const std::string& operands_concat, const int addressnow) const;
    [[nodiscard]] std::tuple<int, int> decompose_Itype_lui_operands(const std::string& operands_concat) const;
    [[nodiscard]] std::tuple<int, int> decompose_mv_operands(const std::string& operands_concat) const;

    [[nodiscard]] std::tuple<bool, std::string> assemble_line_first_pass(const std::string& instruction, const int addressnow);
    [[nodiscard]] std::tuple<bool, std::string> assemble_line_second_pass(const std::string& instruction, const int addressnow) const;

   public:
    Assembler() = default;
    ~Assembler() = default;

    std::string assemble(std::stringstream& inputFile);
};
