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

      loop do
        instruction = instructions.fetch pc
        pc.increment
        execute instruction
      end
    end

    private

    def reset
      @vstack = Stack.new   # a value stack
      @cstack = Stack.new   # a call stack
      @memory = Memory.new  # heap memory
      @pc     = Counter.new # program counter
    end

    def execute(instruction)
      instruction.execute
    rescue Halt
      raise StopIteration
    end
  end
end
