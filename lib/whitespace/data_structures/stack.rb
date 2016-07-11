module Whitespace
  class Stack
    def initialize
      @elements = []
    end

    def push(x)
      @elements.push x
    end

    def pop
      return @elements.pop unless @elements.empty?
      raise EmptyError
    end

    def top
      @elements.last
    end

    def size
      @elements.size
    end
  end
end
