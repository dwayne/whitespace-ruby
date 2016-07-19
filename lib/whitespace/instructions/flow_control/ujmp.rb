module Whitespace::ISA
  class Ujmp < Instruction
    attr_reader :name

    def initialize(vm, name)
      unless Whitespace::Util.is_label?(name)
        raise ArgumentError, "must be a label: #{name}"
      end
      super(vm)
      @name = name
    end

    def execute
      index = Whitespace::Util.find_label(vm.instructions, name)
      vm.pc.change_to index + 1
    end
  end
end
