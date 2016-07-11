require_relative "binop"

module Whitespace::ISA
  class Div < Binop
    def initialize(vm)
      super(vm, :div)
    end
  end
end
