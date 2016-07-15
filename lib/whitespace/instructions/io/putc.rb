module Whitespace::ISA
  class Putc < Instruction
    def initialize(vm, console)
      super(vm)
      @console = console
    end

    def execute
      n = vm.vstack.pop
      @console.printc n
    end
  end
end
