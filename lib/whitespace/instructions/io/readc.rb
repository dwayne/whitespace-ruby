module Whitespace::ISA
  class Readc < Instruction
    def initialize(vm, console)
      super(vm)
      @console = console
    end

    def execute
      ch = @console.getc
      address = vm.vstack.pop
      vm.memory[address] = ch.ord
    end
  end
end
