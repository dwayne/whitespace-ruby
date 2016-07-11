require "test_helper"

module Whitespace::ISA
  describe Push do
    before do
      @vm = Whitespace::VM.new
    end

    describe "initialization" do
      describe "when given a non-integer value" do
        it "raises ArgumentError" do
          e = expect { Push.new(@vm, "1") }.must_raise(ArgumentError)
          e.message.must_match /must be an integer/
        end
      end
    end

    describe "#execute" do
      it "pushes the integer onto the value stack" do
        expect(@vm.vstack.size).must_equal 0

        i = Push.new(@vm, 1)
        i.execute

        expect(@vm.vstack.pop).must_equal 1
        expect(@vm.vstack.size).must_equal 0
      end
    end
  end
end
