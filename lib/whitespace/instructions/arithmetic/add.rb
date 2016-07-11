require_relative "binop"

module Whitespace::ISA
  class Add < Binop
    def initialize(vm)
      super(vm, :add)
    end
  end
end
