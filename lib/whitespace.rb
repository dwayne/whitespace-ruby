module Whitespace
  class Error < StandardError; end
  class EmptyError < Error; end
  class AddressError < Error; end
  class LabelError < Error; end
  class Halt < Error; end
  class ParseError < Error; end
end

require_relative "whitespace/util"
require_relative "whitespace/vm"
require_relative "whitespace/isa"
require_relative "whitespace/parser"
