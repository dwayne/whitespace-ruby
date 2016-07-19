require "test_helper"

module Whitespace
  describe Parser do
    before do
      @parser = Parser.new(:vm, :console)
    end

    describe "#parse" do
      describe "individual instructions" do
        describe "stack manipulation" do
          it "parses Push" do
            instructions = @parser.parse("  \t\t \t\n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Push
            expect(instruction.vm).must_equal :vm
            expect(instruction.n).must_equal -5
          end

          it "parses Dup" do
            instructions = @parser.parse(" \n ")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Dup
            expect(instruction.vm).must_equal :vm
          end

          it "parses Swap" do
            instructions = @parser.parse(" \n\t")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Swap
            expect(instruction.vm).must_equal :vm
          end

          it "parses Discard" do
            instructions = @parser.parse(" \n\n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Discard
            expect(instruction.vm).must_equal :vm
          end

          it "raises Whitespace::ParseError otherwise" do
            [" ", " \t", " \n"].each do |bad_src|
              e = expect { @parser.parse(" \t") }.must_raise ParseError
              expect(e.message).must_match \
                /must be a stack manipulation instruction/
            end
          end
        end

        describe "arithmetic" do
          it "parses Add" do
            instructions = @parser.parse("\t   ")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Add
            expect(instruction.vm).must_equal :vm
          end

          it "parses Sub" do
            instructions = @parser.parse("\t  \t")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Sub
            expect(instruction.vm).must_equal :vm
          end

          it "parses Mul" do
            instructions = @parser.parse("\t  \n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Mul
            expect(instruction.vm).must_equal :vm
          end

          it "parses Div" do
            instructions = @parser.parse("\t \t ")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Div
            expect(instruction.vm).must_equal :vm
          end

          it "parses Mod" do
            instructions = @parser.parse("\t \t\t")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Mod
            expect(instruction.vm).must_equal :vm
          end

          it "raises Whitespace::ParseError otherwise" do
            ["\t ", "\t \n", "\t  ", "\t \t", "\t \t\n"].each do |bad_src|
              e = expect { @parser.parse(bad_src) }.must_raise ParseError
              expect(e.message).must_match /must be an arithmetic instruction/
            end
          end
        end

        describe "heap access" do
          it "parses Store" do
            instructions = @parser.parse("\t\t ")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Store
            expect(instruction.vm).must_equal :vm
          end

          it "parses Retrieve" do
            instructions = @parser.parse("\t\t\t")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Retrieve
            expect(instruction.vm).must_equal :vm
          end

          it "raises Whitespace::ParseError otherwise" do
            ["\t\t", "\t\t\n"].each do |bad_src|
              e = expect { @parser.parse(bad_src) }.must_raise ParseError
              expect(e.message).must_match /must be a heap instruction/
            end
          end
        end

        describe "flow control" do
          it "parses Label" do
            instructions = @parser.parse("\n   \n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Label
            expect(instruction.vm).must_equal :vm
            expect(instruction.name).must_equal " "
          end

          it "parses Call" do
            instructions = @parser.parse("\n \t \n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Call
            expect(instruction.vm).must_equal :vm
            expect(instruction.name).must_equal " "
          end

          it "parses Ujmp" do
            instructions = @parser.parse("\n \n \n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Ujmp
            expect(instruction.vm).must_equal :vm
            expect(instruction.name).must_equal " "
          end

          it "parses Zjmp" do
            instructions = @parser.parse("\n\t  \n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Zjmp
            expect(instruction.vm).must_equal :vm
            expect(instruction.name).must_equal " "
          end

          it "parses Njmp" do
            instructions = @parser.parse("\n\t\t \n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Njmp
            expect(instruction.vm).must_equal :vm
            expect(instruction.name).must_equal " "
          end

          it "parses Return" do
            instructions = @parser.parse("\n\t\n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Return
            expect(instruction.vm).must_equal :vm
          end

          it "parses End" do
            instructions = @parser.parse("\n\n\n")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::End
            expect(instruction.vm).must_equal :vm
          end

          it "raises Whitespace::ParseError otherwise" do
            ["\n", "\n ", "\n\t", "\n\n", "\n\n ", "\n\n\t"].each do |bad_src|
              e = expect { @parser.parse(bad_src) }.must_raise ParseError
              expect(e.message).must_match /must be a flow control instruction/
            end

            ["\n  ", "\n \t", "\n \n", "\n\t ", "\n\t\t"].each do |bad_src|
              e = expect { @parser.parse(bad_src) }.must_raise ParseError
              expect(e.message).must_match /name must be terminated by a LF/
            end
          end
        end

        describe "I/O" do
          it "parses Putc" do
            instructions = @parser.parse("\t\n  ")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Putc
            expect(instruction.vm).must_equal :vm
            expect(instruction.console).must_equal :console
          end

          it "parses Putn" do
            instructions = @parser.parse("\t\n \t")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Putn
            expect(instruction.vm).must_equal :vm
            expect(instruction.console).must_equal :console
          end

          it "parses Readc" do
            instructions = @parser.parse("\t\n\t ")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Readc
            expect(instruction.vm).must_equal :vm
            expect(instruction.console).must_equal :console
          end

          it "parses Readn" do
            instructions = @parser.parse("\t\n\t\t")
            instruction = instructions.first

            expect(instructions.length).must_equal 1
            expect(instruction).must_be_instance_of ISA::Readn
            expect(instruction.vm).must_equal :vm
            expect(instruction.console).must_equal :console
          end

          it "raises Whitespace::ParseError otherwise" do
            ["\t\n", "\t\n ", "\t\n\t", "\t\n\n", "\t\n \n", "\t\n\t\n"].each do |bad_src|
              e = expect { @parser.parse(bad_src) }.must_raise ParseError
              expect(e.message).must_match /must be an I\/O instruction/
            end
          end
        end

        describe "invalid IMP" do
          it "raises Whitespace::ParseError" do
            e = expect { @parser.parse("\t") }.must_raise ParseError
            expect(e.message).must_match /must be an IMP/
          end
        end
      end

      describe "numbers" do
        describe "positive" do
          it "parses 1" do
            instruction = @parser.parse("   \t\n").first
            expect(instruction.n).must_equal 1
          end

          it "parses 2" do
            instruction = @parser.parse("   \t \n").first
            expect(instruction.n).must_equal 2
          end

          it "parses 5" do
            instruction = @parser.parse("   \t \t\n").first
            expect(instruction.n).must_equal 5
          end

          it "raises Whitespace::ParseError otherwise" do
            e = expect { @parser.parse("   \n") }.must_raise ParseError
            expect(e.message).must_match /number must have a value part/

            e = expect { @parser.parse("   \t") }.must_raise ParseError
            expect(e.message).must_match /number must be terminated by a LF/
          end
        end

        describe "negative" do
          it "parses -1" do
            instruction = @parser.parse("  \t\t\n").first
            expect(instruction.n).must_equal -1
          end

          it "parses -2" do
            instruction = @parser.parse("  \t\t \n").first
            expect(instruction.n).must_equal -2
          end

          it "parses -5" do
            instruction = @parser.parse("  \t\t \t\n").first
            expect(instruction.n).must_equal -5
          end

          it "raises Whitespace::ParseError otherwise" do
            e = expect { @parser.parse("  \t\n") }.must_raise ParseError
            expect(e.message).must_match /number must have a value part/

            e = expect { @parser.parse("  \t\t") }.must_raise ParseError
            expect(e.message).must_match /number must be terminated by a LF/
          end
        end

        describe "zero" do
          it "parses 0" do
            # there is an infinite number of representations of 0
            ["    \n", "  \t \n", "     \n", "  \t  \n"].each do |zero_src|
              instruction = @parser.parse(zero_src).first
              expect(instruction.n).must_equal 0
            end
          end
        end
      end

      describe "names" do
        it "parses one or more LF terminated spaces/tabs" do
          instruction = @parser.parse("\n   \n").first
          expect(instruction.name).must_equal " "

          instruction = @parser.parse("\n  \t\n").first
          expect(instruction.name).must_equal "\t"

          instruction = @parser.parse("\n  \t \t  \n").first
          expect(instruction.name).must_equal "\t \t  "
        end

        it "raises Whitespace::ParseError otherwise" do
          e = expect { @parser.parse("\n  \n") }.must_raise ParseError
          expect(e.message).must_match /name must be non-empty/

          e = expect { @parser.parse("\n   ") }.must_raise ParseError
          expect(e.message).must_match /name must be terminated by a LF/
        end
      end
    end
  end
end
