module Whitespace::ISA
  class Retrieve < Instruction
    def execute
      address = vm.vstack.pop

      vm.vstack.push vm.memory[address]
    end
  end
end
