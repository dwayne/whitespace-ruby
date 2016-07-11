module Whitespace
  module Util
    class << self
      def is_integer?(n)
        n.is_a? Integer
      end

      def is_binop?(op)
        BINOPS.include? op
      end
    end

    BINOPS = {
      add: lambda { |l, r| l + r },
      sub: lambda { |l, r| l - r },
      mul: lambda { |l, r| l * r },
      div: lambda { |l, r| l / r },
      mod: lambda { |l, r| l % r }
    }
  end
end
