require "test_helper"

module Whitespace::ISA
  describe Call do
    before do
      @vm = Whitespace::VM.new
    end

    describe "initialization" do
      describe "when given a non-label value" do
        it "raises ArgumentError" do
          e = expect { Call.new(@vm, :not_a_label) }.must_raise(ArgumentError)
          e.message.must_match /must be a label/
        end
      end
    end

    describe "#execute" do
      describe "when the label doesn't exist" do
        it "raises Whitespace::LabelError" do
          e = expect { Call.new(@vm, " ").execute }.must_raise \
            Whitespace::LabelError
          expect(e.message).must_match /missing: " "/
        end
      end

      describe "when the label does exist" do
        it "puts the current value of the pc on the call stack and sets it " \
            "to the index of the instruction after the label" do
          @vm.load [
            "instruction 1",
            Label.new(@vm, " "),
            "instruction 3",
            "instruction 4",
            "instruction 5"
          ]
          @vm.pc.change_to 4

          expect(@vm.cstack.size).must_equal 0

          Call.new(@vm, " ").execute

          expect(@vm.cstack.size).must_equal 1
          expect(@vm.cstack.top).must_equal 4
          expect(@vm.pc.to_int).must_equal 2
        end
      end
    end
  end
end
