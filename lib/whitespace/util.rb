module Whitespace
  module Util
    class << self
      def is_integer?(n)
        n.is_a? Integer
      end

      def is_ascii?(n)
        n == 10 || n == 13 || (n >= 32 && n <= 127)
      end

      def is_binop?(op)
        BINOPS.include? op
      end

      def is_label?(name)
        name.instance_of?(String) && !/\A[ \t]+\z/.match(name).nil?
      end

      def find_label(instructions, name)
        instructions.each_with_index do |instr, i|
          return i if instr.instance_of?(ISA::Label) && instr.name == name
        end

        raise LabelError, "missing: \"#{name}\""
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
