require "test_helper"

module Whitespace::ISA
  describe Zjmp do
    before do
      @vm = Whitespace::VM.new
    end

    describe "initialization" do
      describe "when given a non-label value" do
        it "raises ArgumentError" do
          e = expect { Zjmp.new(@vm, :not_a_label) }.must_raise(ArgumentError)
          e.message.must_match /must be a label/
        end
      end
    end

    describe "#execute" do
      describe "when the value stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect { Zjmp.new(@vm, " ").execute }.must_raise \
            Whitespace::EmptyError
        end
      end

      describe "when the value stack has at least 1 element" do
        describe "when the top element is 0" do
          before do
            @vm.vstack.push 0
          end

          describe "when the label exists" do
            it "changes the current value of the pc to the index of the " \
                "instruction after the label" do
              @vm.load [
                "instruction 1",
                Label.new(@vm, " "),
                "instruction 3"
              ]
              expect(@vm.pc.to_int).must_equal 0

              Zjmp.new(@vm, " ").execute

              expect(@vm.pc.to_int).must_equal 2
              expect(@vm.vstack.size).must_equal 0
            end
          end

          describe "when the label doesn't exist" do
            it "raises Whitespace::LabelError" do
              e = expect { Zjmp.new(@vm, " ").execute }.must_raise \
                Whitespace::LabelError
              expect(e.message).must_match /missing: " "/
            end
          end
        end

        describe "when the top element is non-zero" do
          before do
            @vm.vstack.push 1
          end

          describe "when the label exists" do
            it "pops the top element but does not change the pc" do
              @vm.load [
                "instruction 1",
                Label.new(@vm, " "),
                "instruction 3"
              ]

              expect(@vm.pc.to_int).must_equal 0

              Zjmp.new(@vm, " ").execute

              expect(@vm.pc.to_int).must_equal 0
              expect(@vm.vstack.size).must_equal 0
            end
          end

          describe "when the label doesn't exist" do
            it "pops the top element but does not change the pc" do
              expect(@vm.pc.to_int).must_equal 0

              Zjmp.new(@vm, " ").execute

              expect(@vm.pc.to_int).must_equal 0
              expect(@vm.vstack.size).must_equal 0
            end
          end
        end
      end
    end
  end
end
