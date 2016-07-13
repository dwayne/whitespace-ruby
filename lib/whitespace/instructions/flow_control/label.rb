module Whitespace::ISA
  class Label < Instruction
    attr_reader :name

    def initialize(vm, name)
      unless Whitespace::Util.is_label?(name)
        raise ArgumentError, "must be a label: #{name}"
      end
      super(vm)
      @name = name
    end

    def execute
    end
  end
end
