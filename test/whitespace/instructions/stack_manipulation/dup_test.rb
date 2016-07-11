require "test_helper"

module Whitespace::ISA
  describe Dup do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect(@vm.vstack.size).must_equal 0

          expect { Dup.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack is not empty" do
        it "duplicates the top element on the value stack" do
          @vm.vstack.push 1
          expect(@vm.vstack.size).must_equal 1

          Dup.new(@vm).execute

          expect(@vm.vstack.pop).must_equal 1
          expect(@vm.vstack.pop).must_equal 1
          expect(@vm.vstack.size).must_equal 0
        end
      end
    end
  end
end
