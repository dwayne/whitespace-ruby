require "test_helper"

module Whitespace::ISA
  describe Putc do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect { Putc.new(@vm, Whitespace::Console.new).execute }.must_raise \
            Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 1 element" do
        describe "when the top element is an ASCII character" do
          it "outputs it as a character" do
            @vm.vstack.push 65
            expect(@vm.vstack.size).must_equal 1

            expect { Putc.new(@vm, Whitespace::Console.new).execute } \
              .must_output "A"
            expect(@vm.vstack.size).must_equal 0
          end
        end

        describe "when the top element is not an ASCII character" do
          it "raises ArgumentError" do
            @vm.vstack.push 0
            expect(@vm.vstack.size).must_equal 1

            e = expect { Putc.new(@vm, Whitespace::Console.new).execute } \
              .must_raise ArgumentError
            expect(e.message).must_match /must be an ASCII character/
          end
        end
      end
    end
  end
end
