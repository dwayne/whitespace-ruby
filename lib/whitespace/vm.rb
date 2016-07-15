require_relative "data_structures/console"
require_relative "data_structures/counter"
require_relative "data_structures/memory"
require_relative "data_structures/stack"

module Whitespace
  class VM
    attr_reader :instructions, :vstack, :cstack, :memory, :pc

    def initialize
      @instructions = []
      reset
    end

    def load(instructions)
      @instructions = Array(instructions)
    end

    def run
      reset

      # TODO: Execute instructions
    end

    private

    def reset
      @vstack = Stack.new   # a value stack
      @cstack = Stack.new   # a call stack
      @memory = Memory.new  # heap memory
      @pc     = Counter.new # program counter
    end
  end
end
