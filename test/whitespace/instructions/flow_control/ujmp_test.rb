require "test_helper"

module Whitespace::ISA
  describe Ujmp do
    before do
      @vm = Whitespace::VM.new
    end

    describe "initialization" do
      describe "when given a non-label value" do
        it "raises ArgumentError" do
          e = expect { Ujmp.new(@vm, :not_a_label) }.must_raise(ArgumentError)
          e.message.must_match /must be a label/
        end
      end
    end

    describe "#execute" do
      describe "when the label doesn't exist" do
        it "raises Whitespace::LabelError" do
          e = expect { Ujmp.new(@vm, " ").execute }.must_raise \
            Whitespace::LabelError
          expect(e.message).must_match /missing: " "/
        end
      end

      describe "when the label does exist" do
        it "changes the current value of the pc to the index of the " \
            "instruction after the label" do
          @vm.load [
            Label.new(@vm, " "),
            "instruction 2",
            "instruction 3"
          ]
          @vm.pc.change_to 2

          Ujmp.new(@vm, " ").execute

          expect(@vm.pc.to_int).must_equal 1
        end
      end
    end
  end
end
