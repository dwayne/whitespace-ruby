require "test_helper"

module Whitespace
  describe VM do
    before do
      @vm = VM.new
    end

    describe "#run" do
      it "executes each instruction one by one until an explicit " \
          "end instruction is reached" do
        @vm.load [
          ISA::Push.new(@vm, 3),
          ISA::Dup.new(@vm),
          ISA::Mul.new(@vm),
          ISA::End.new(@vm),
          ISA::Dup.new(@vm)
        ]

        @vm.run

        expect(@vm.vstack.size).must_equal 1
        expect(@vm.vstack.top).must_equal 9
      end

      it "raises IndexError when no end instruction is given" do
        @vm.load [
          ISA::Push.new(@vm, 3),
          ISA::Dup.new(@vm),
          ISA::Mul.new(@vm)
        ]

        expect { @vm.run }.must_raise IndexError
      end

      it "allows any exceptions raised during instruction execution " \
          "to pass through" do
        instruction = Object.new
        def instruction.execute
          any_exception = Class.new(StandardError)
          raise any_exception, "any exception"
        end

        @vm.load instruction

        e = expect { @vm.run }.must_raise StandardError
        expect(e.message).must_match /any exception/
      end
    end

    describe "an example program" do
      it "counts from 1 to 10" do
        expect do
          console = Console.new

          @vm.load [
            ISA::Push.new(@vm, 1),        # Put a 1 on the stack
            ISA::Label.new(@vm, " "),     # Set a Label at this point
            ISA::Dup.new(@vm),            # Duplicate the top stack item
            ISA::Putn.new(@vm, console),  # Output the current value
            ISA::Push.new(@vm, 10),       # Put 10 (newline) on the stack...
            ISA::Putc.new(@vm, console),  # ...and output the newline
            ISA::Push.new(@vm, 1),        # Put a 1 on the stack
            ISA::Add.new(@vm),            # Increment our current value
            ISA::Dup.new(@vm),            # Duplicate the value to test it
            ISA::Push.new(@vm, 11),       # Push 11 onto the stack
            ISA::Sub.new(@vm),            # Subtraction
            ISA::Zjmp.new(@vm, "\t"),     # If we have a 0, jump to the end
            ISA::Ujmp.new(@vm, " "),      # Jump to the start
            ISA::Label.new(@vm, "\t"),    # Set the end label
            ISA::Discard.new(@vm),        # Discard our accumulator, to be tidy
            ISA::End.new(@vm)             # Finish
          ]

          @vm.run
        end.must_output("1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n")
      end
    end
  end
end
