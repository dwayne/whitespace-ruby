module Whitespace::ISA
  class Putn < Instruction
    attr_reader :console

    def initialize(vm, console)
      super(vm)
      @console = console
    end

    def execute
      n = vm.vstack.pop
      console.printn n
    end
  end
end
