require "test_helper"

module Whitespace::ISA
  describe Swap do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect(@vm.vstack.size).must_equal 0

          expect { Swap.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has one element" do
        it "raises Whitespace::EmptyError" do
          @vm.vstack.push 1
          expect(@vm.vstack.size).must_equal 1

          expect { Swap.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 2 elements" do
        it "swaps the top two elements on the stack" do
          @vm.vstack.push 1
          @vm.vstack.push 2
          @vm.vstack.push 3
          expect(@vm.vstack.size).must_equal 3

          Swap.new(@vm).execute

          expect(@vm.vstack.pop).must_equal 2
          expect(@vm.vstack.pop).must_equal 3
          expect(@vm.vstack.size).must_equal 1
        end
      end
    end
  end
end
