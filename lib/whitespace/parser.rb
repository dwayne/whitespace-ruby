module Whitespace
  class Parser
    attr_reader :vm, :console

    def initialize(vm, console)
      @vm = vm
      @console = console
    end

    def parse(src)
      parse_init(src)
      parse_start
    end

    SPACE = " "
    TAB   = "\t"
    LF    = "\n"

    private

    attr_reader :instructions

    def parse_init(src)
      @tokens = src.to_s.gsub(/[^ \t\n]+/, '')
      @index = 0
      @instructions = []
    end

    def parse_start
      case next_token
      when SPACE
        parse_stack_manipulation
      when TAB
        case next_token
        when SPACE
          parse_arithmetic
        when TAB
          parse_heap
        when LF
          parse_io
        else
          raise ParseError, "must be an IMP"
        end
      when LF
        parse_flow_control
      else
        instructions
      end
    end

    def parse_stack_manipulation
      case next_token
      when SPACE
        n = parse_number
        append_and_continue ISA::Push.new(vm, n)
      when LF
        case next_token
        when SPACE
          append_and_continue ISA::Dup.new(vm)
        when TAB
          append_and_continue ISA::Swap.new(vm)
        when LF
          append_and_continue ISA::Discard.new(vm)
        else
          raise ParseError, "must be a stack manipulation instruction"
        end
      else
        raise ParseError, "must be a stack manipulation instruction"
      end
    end

    def parse_arithmetic
      case next_token
      when SPACE
        case next_token
        when SPACE
          append_and_continue ISA::Add.new(vm)
        when TAB
          append_and_continue ISA::Sub.new(vm)
        when LF
          append_and_continue ISA::Mul.new(vm)
        else
          raise ParseError, "must be an arithmetic instruction"
        end
      when TAB
        case next_token
        when SPACE
          append_and_continue ISA::Div.new(vm)
        when TAB
          append_and_continue ISA::Mod.new(vm)
        else
          raise ParseError, "must be an arithmetic instruction"
        end
      else
        raise ParseError, "must be an arithmetic instruction"
      end
    end

    def parse_heap
      case next_token
      when SPACE
        append_and_continue ISA::Store.new(vm)
      when TAB
        append_and_continue ISA::Retrieve.new(vm)
      else
        raise ParseError, "must be a heap instruction"
      end
    end

    def parse_flow_control
      case next_token
      when SPACE
        case next_token
        when SPACE
          name = parse_name
          append_and_continue ISA::Label.new(vm, name)
        when TAB
          name = parse_name
          append_and_continue ISA::Call.new(vm, name)
        when LF
          name = parse_name
          append_and_continue ISA::Ujmp.new(vm, name)
        else
          raise ParseError, "must be a flow control instruction"
        end
      when TAB
        case next_token
        when SPACE
          name = parse_name
          append_and_continue ISA::Zjmp.new(vm, name)
        when TAB
          name = parse_name
          append_and_continue ISA::Njmp.new(vm, name)
        when LF
          append_and_continue ISA::Return.new(vm)
        else
          raise ParseError, "must be a flow control instruction"
        end
      when LF
        case next_token
        when LF
          append_and_continue ISA::End.new(vm)
        else
          raise ParseError, "must be a flow control instruction"
        end
      else
        raise ParseError, "must be a flow control instruction"
      end
    end

    def parse_io
      case next_token
      when SPACE
        case next_token
        when SPACE
          append_and_continue ISA::Putc.new(vm, console)
        when TAB
          append_and_continue ISA::Putn.new(vm, console)
        else
          raise ParseError, "must be an I/O instruction"
        end
      when TAB
        case next_token
        when SPACE
          append_and_continue ISA::Readc.new(vm, console)
        when TAB
          append_and_continue ISA::Readn.new(vm, console)
        else
          raise ParseError, "must be an I/O instruction"
        end
      else
        raise ParseError, "must be an I/O instruction"
      end
    end

    def parse_number
      parse_sign * parse_value
    end

    def parse_sign
      case next_token
      when SPACE
        1
      when TAB
        -1
      else
        raise ParseError, "must be a sign token"
      end
    end

    def parse_value
      parse_value_rec(0, 0, next_token)
    end

    def parse_value_rec(n, len, token)
      case token
      when SPACE
        parse_value_rec(2 * n, len + 1, next_token)
      when TAB
        parse_value_rec(2 * n + 1, len + 1, next_token)
      when LF
        if len > 0
          n
        else
          raise ParseError, "number must have a value part"
        end
      else
        raise ParseError, "number must be terminated by a LF"
      end
    end

    def parse_name
      parse_name_rec("", 0, next_token)
    end

    def parse_name_rec(name, len, token)
      case token
      when SPACE
        parse_name_rec(name + " ", len + 1, next_token)
      when TAB
        parse_name_rec(name + "\t", len + 1, next_token)
      when LF
        if len > 0
          name
        else
          raise ParseError, "name must be non-empty"
        end
      else
        raise ParseError, "name must be terminated by a LF"
      end
    end

    def next_token
      @index += 1
      @tokens[@index - 1]
    end

    def append_and_continue(instruction)
      @instructions << instruction
      parse_start
    end
  end
end
