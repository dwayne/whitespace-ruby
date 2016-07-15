module Whitespace
  class Console
    attr_reader :stdin, :stdout

    def initialize(stdin: $stdin, stdout: $stdout)
      @stdin = stdin
      @stdout = stdout
    end

    def printc(n)
      unless Util.is_ascii?(n)
        raise ArgumentError, "must be an ASCII character: #{n}"
      end
      stdout.print n.chr
    end

    def printn(n)
      unless Util.is_integer?(n)
        raise ArgumentError, "must be an integer: #{n}"
      end
      stdout.print n
    end

    def getc
      if c = stdin.getc
        unless Util.is_ascii?(c.ord)
          raise ArgumentError, "must be an ASCII character: #{c}"
        end
        c
      else
        raise ArgumentError, "must be an ASCII character: EOF"
      end
    end

    LINE_SEPARATOR = "\n"

    def getn
      input = ""
      loop do
        c = stdin.getc
        break if c.nil?
        input << c
        break if c == LINE_SEPARATOR
      end

      raise ArgumentError, "must be an integer: EOF" if input.empty?

      input = input.chomp(LINE_SEPARATOR)
      begin
        Integer input
      rescue
        raise ArgumentError, "must be an integer: #{input}"
      end
    end
  end
end
