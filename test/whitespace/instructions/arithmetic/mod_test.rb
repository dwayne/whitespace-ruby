require "test_helper"

module Whitespace::ISA
  describe Mod do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect(@vm.vstack.size).must_equal 0

          expect { Mod.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has one element" do
        it "raises Whitespace::EmptyError" do
          @vm.vstack.push 1
          expect(@vm.vstack.size).must_equal 1

          expect { Mod.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 2 elements" do
        it "replaces the top 2 elements with their remainder" do
          @vm.vstack.push 1
          @vm.vstack.push 5
          @vm.vstack.push 3
          expect(@vm.vstack.size).must_equal 3

          Mod.new(@vm).execute

          expect(@vm.vstack.pop).must_equal 2
          expect(@vm.vstack.pop).must_equal 1
          expect(@vm.vstack.size).must_equal 0
        end
      end

      # TODO: Test for modulo by 0
    end
  end
end
