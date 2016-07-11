module Whitespace
  class Counter
    def initialize
      @value = 0
    end

    def increment
      @value += 1
    end

    def change_to(new_value)
      new_value = new_value.to_i
      if new_value >= 0
        @value = new_value
      else
        raise ArgumentError, "must be non-negative: #{new_value}"
      end
    end

    def to_int
      @value
    end
  end
end
