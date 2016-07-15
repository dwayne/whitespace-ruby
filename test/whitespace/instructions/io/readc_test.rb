require "test_helper"

module Whitespace::ISA
  describe Readc do
    before do
      @vm = Whitespace::VM.new
      @stdin = Object.new
    end

    describe "#execute" do
      describe "when there is no character" do
        it "raises ArgumentError" do
          def @stdin.getc
          end

          console = Whitespace::Console.new(stdin: @stdin)
          e = expect { Readc.new(@vm, console).execute }.must_raise \
            ArgumentError
          expect(e.message).must_match /must be an ASCII character/
        end
      end

      describe "when there is a character" do
        describe "when it is an ASCII character" do
          before do
            def @stdin.getc
              "A"
            end
          end

          describe "when the value stack is empty" do
            it "raises Whitespace::EmptyError" do
              expect(@vm.vstack.size).must_equal 0

              console = Whitespace::Console.new(stdin: @stdin)
              expect { Readc.new(@vm, console).execute }.must_raise \
                Whitespace::EmptyError
            end
          end

          describe "when the value stack has at least 1 element" do
            it "reads the character and places its integer value at the " \
                "address in the heap given by the top of the stack" do
              @vm.vstack.push :address
              expect(@vm.vstack.size).must_equal 1

              console = Whitespace::Console.new(stdin: @stdin)
              Readc.new(@vm, console).execute

              expect(@vm.memory[:address]).must_equal 65
              expect(@vm.vstack.size).must_equal 0
            end
          end
        end

        describe "when it is not an ASCII character" do
          it "raises ArgumentError" do
            def @stdin.getc
              "\a"
            end

            console = Whitespace::Console.new(stdin: @stdin)
            e = expect { Readc.new(@vm, console).execute }.must_raise \
              ArgumentError
            expect(e.message).must_match /must be an ASCII character/
          end
        end
      end
    end
  end
end
