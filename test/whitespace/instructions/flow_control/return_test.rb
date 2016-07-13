require "test_helper"

module Whitespace::ISA
  describe Return do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the call stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect { Return.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the call stack has at least 1 element" do
        it "changes the current value of the pc to the value taken from the " \
            "top of the call stack" do
          @vm.cstack.push 4
          @vm.cstack.push 5

          expect(@vm.pc.to_int).must_equal 0

          Return.new(@vm).execute

          expect(@vm.pc.to_int).must_equal 5
          expect(@vm.cstack.top).must_equal 4
          expect(@vm.cstack.size).must_equal 1
        end
      end
    end
  end
end
