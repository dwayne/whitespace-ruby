require "test_helper"

module Whitespace::ISA
  describe Retrieve do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect(@vm.vstack.size).must_equal 0

          expect { Retrieve.new(@vm).execute }.must_raise Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 1 element" do
        describe "when the address does not exist" do
          it "raises Whitespace::AddressError" do
            @vm.vstack.push 1
            @vm.vstack.push :address
            expect(@vm.vstack.size).must_equal 2

            expect { Retrieve.new(@vm).execute }.must_raise \
              Whitespace::AddressError
          end
        end

        describe "when the address exists" do
          it "retrieves the value at the given address and puts it on top " \
              "the value stack" do
            @vm.memory[:address] = :value

            @vm.vstack.push 1
            @vm.vstack.push :address
            expect(@vm.vstack.size).must_equal 2

            Retrieve.new(@vm).execute

            expect(@vm.vstack.pop).must_equal :value
            expect(@vm.vstack.pop).must_equal 1
            expect(@vm.vstack.size).must_equal 0
          end
        end
      end
    end
  end
end
