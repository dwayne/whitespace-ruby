module Whitespace::ISA
  class Store < Instruction
    def execute
      value = vm.vstack.pop
      address = vm.vstack.pop

      vm.memory[address] = value
    end
  end
end
