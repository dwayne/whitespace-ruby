require_relative "binop"

module Whitespace::ISA
  class Mod < Binop
    def initialize(vm)
      super(vm, :mod)
    end
  end
end
