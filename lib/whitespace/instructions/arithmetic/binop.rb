module Whitespace::ISA
  class Binop < Instruction
    def initialize(vm, op)
      unless Whitespace::Util.is_binop?(op)
        raise ArgumentError, "must be a binary operator: #{op}"
      end
      super(vm)
      @op = op
    end

    def execute
      right = vm.vstack.pop
      left = vm.vstack.pop

      vm.vstack.push Whitespace::Util::BINOPS[@op].call(left, right)
    end
  end
end
