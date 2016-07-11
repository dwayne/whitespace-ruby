module Whitespace
  class Memory
    def initialize
      @store = {}
    end

    def [](address)
      if @store.key?(address)
        @store[address]
      else
        raise AddressError, "no such address exists: #{address}"
      end
    end

    def []=(address, value)
      @store[address] = value
    end
  end
end
