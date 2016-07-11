require "test_helper"

module Whitespace::ISA
  describe Instruction do
    describe "#execute" do
      it "raises NotImplementedError" do
        expect { Instruction.new(:vm).execute }.must_raise NotImplementedError
      end
    end
  end
end
