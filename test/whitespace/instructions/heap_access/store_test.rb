require "test_helper"

module Whitespace::ISA
  describe Store do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect(@vm.vstack.size).must_equal 0

          expect { Store.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has 1 element" do
        it "raises Whitespace::EmptyError" do
          @vm.vstack.push :address
          expect(@vm.vstack.size).must_equal 1

          expect { Store.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 2 elements" do
        it "stores the value at the given address in memory" do
          @vm.vstack.push 1
          @vm.vstack.push :address
          @vm.vstack.push :value
          expect(@vm.vstack.size).must_equal 3
          expect { @vm.memory[:address] }.must_raise Whitespace::AddressError

          Store.new(@vm).execute

          expect(@vm.memory[:address]).must_equal :value
          expect(@vm.vstack.pop).must_equal 1
          expect(@vm.vstack.size).must_equal 0
        end
      end
    end
  end
end
