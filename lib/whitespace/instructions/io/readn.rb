module Whitespace::ISA
  class Readn < Instruction
    attr_reader :console

    def initialize(vm, console)
      super(vm)
      @console = console
    end

    def execute
      n = console.getn
      address = vm.vstack.pop
      vm.memory[address] = n
    end
  end
end
