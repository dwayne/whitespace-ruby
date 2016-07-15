require "test_helper"

module Whitespace::ISA
  describe Putn do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect { Putn.new(@vm, Whitespace::Console.new).execute }.must_raise \
            Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 1 element" do
        describe "when it is an integer" do
          it "outputs it as an integer" do
            @vm.vstack.push 65
            expect(@vm.vstack.size).must_equal 1

            expect { Putn.new(@vm, Whitespace::Console.new).execute } \
              .must_output "65"
            expect(@vm.vstack.size).must_equal 0
          end
        end

        describe "when it is not an integer" do
          it "raises ArgumentError" do
            @vm.vstack.push "6s"
            expect(@vm.vstack.size).must_equal 1

            e = expect { Putn.new(@vm, Whitespace::Console.new).execute } \
              .must_raise ArgumentError
            expect(e.message).must_match /must be an integer: 6s/
          end
        end
      end
    end
  end
end
