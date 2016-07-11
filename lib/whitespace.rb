module Whitespace
  class Error < StandardError; end
  class EmptyError < Error; end
  class AddressError < Error; end
end

require_relative "whitespace/vm"
