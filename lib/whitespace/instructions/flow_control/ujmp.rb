module Whitespace::ISA
  class Ujmp < Instruction
    def initialize(vm, name)
      unless Whitespace::Util.is_label?(name)
        raise ArgumentError, "must be a label: #{name}"
      end
      super(vm)
      @name = name
    end

    def execute
      index = Whitespace::Util.find_label(vm.instructions, @name)
      vm.pc.change_to index + 1
    end
  end
end
