require_relative "binop"

module Whitespace::ISA
  class Sub < Binop
    def initialize(vm)
      super(vm, :sub)
    end
  end
end
