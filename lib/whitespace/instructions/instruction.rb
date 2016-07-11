module Whitespace::ISA
  class Instruction
    attr_reader :vm

    def initialize(vm)
      @vm = vm
    end

    def execute
      raise NotImplementedError
    end
  end
end
