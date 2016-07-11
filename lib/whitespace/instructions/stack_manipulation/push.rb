module Whitespace::ISA
  class Push < Instruction
    def initialize(vm, n)
      unless Whitespace::Util.is_integer?(n)
        raise ArgumentError, "must be an integer: #{n}"
      end
      super(vm)
      @n = n
    end

    def execute
      vm.vstack.push @n
    end
  end
end
