require "test_helper"

module Whitespace::ISA
  describe Label do
    before do
      @vm = Whitespace::VM.new
    end

    describe "initialization" do
      describe "when given a non-label value" do
        it "raises ArgumentError" do
          e = expect { Label.new(@vm, :not_a_label) }.must_raise(ArgumentError)
          e.message.must_match /must be a label/
        end
      end
    end

    describe "#execute" do
      it "doesn't raise NotImplementedError" do
        Label.new(@vm, " ").execute
      end
    end
  end
end
