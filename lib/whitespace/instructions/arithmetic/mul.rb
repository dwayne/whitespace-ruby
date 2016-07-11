require_relative "binop"

module Whitespace::ISA
  class Mul < Binop
    def initialize(vm)
      super(vm, :mul)
    end
  end
end
