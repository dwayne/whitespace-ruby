module Whitespace::ISA
  class Putc < Instruction
    attr_reader :console

    def initialize(vm, console)
      super(vm)
      @console = console
    end

    def execute
      n = vm.vstack.pop
      console.printc n
    end
  end
end
