module Whitespace::ISA
  class Return < Instruction
    def execute
      vm.pc.change_to vm.cstack.pop
    end
  end
end
