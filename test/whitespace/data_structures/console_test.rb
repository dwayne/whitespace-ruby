require "test_helper"

module Whitespace
  describe Console do
    before do
      @stdin = Object.new
    end

    describe "#printc" do
      describe "when given an ASCII character" do
        it "prints it" do
          expect { Console.new.printc 65 }.must_output("A")
        end
      end

      describe "when not given an ASCII character" do
        it "raises ArgumentError" do
          e = expect { Console.new.printc 0 }.must_raise ArgumentError
          expect(e.message).must_match /must be an ASCII character: 0/
        end
      end
    end

    describe "#printn" do
      describe "when given an integer" do
        it "prints it" do
          expect { Console.new.printn 65 }.must_output("65")
        end
      end

      describe "when not given an integer" do
        it "raises ArgumentError" do
          e = expect { Console.new.printn :x }.must_raise ArgumentError
          expect(e.message).must_match /must be an integer/
        end
      end
    end

    describe "#getc" do
      describe "when given an ASCII character" do
        it "gets it" do
          def @stdin.getc
            "A"
          end

          expect(Console.new(stdin: @stdin).getc).must_equal "A"
        end
      end

      describe "when not given an ASCII character" do
        describe "when there is a character" do
          it "raises ArgumentError" do
            def @stdin.getc
              "\a"
            end

            e = expect { Console.new(stdin: @stdin).getc }.must_raise ArgumentError
            expect(e.message).must_match /must be an ASCII character/
          end
        end

        describe "when EOF" do
          it "raises ArgumentError" do
            def @stdin.getc
            end

            e = expect { Console.new(stdin: @stdin).getc }.must_raise ArgumentError
            expect(e.message).must_match /must be an ASCII character: EOF/
          end
        end
      end
    end

    describe "#getn" do
      describe "when given an integer" do
        it "gets it" do
          def @stdin.getc
            @chars = ["1", "2", "3"]
            @i ||= 0

            @i += 1
            @chars[@i - 1]
          end

          expect(Console.new(stdin: @stdin).getn).must_equal 123
        end
      end

      describe "when not given an integer" do
        describe "when there is at least one character" do
          it "raises ArgumentError" do
            def @stdin.getc
              "\n"
            end

            e = expect { Console.new(stdin: @stdin).getn }.must_raise ArgumentError
            expect(e.message).must_match /must be an integer: /
          end
        end

        describe "when EOF" do
          it "raises ArgumentError" do
            def @stdin.getc
            end

            e = expect { Console.new(stdin: @stdin).getn }.must_raise ArgumentError
            expect(e.message).must_match /must be an integer: EOF/
          end
        end
      end
    end
  end
end
