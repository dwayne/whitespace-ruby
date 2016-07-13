require "test_helper"

module Whitespace::ISA
  describe End do
    before do
      @vm = Whitespace::VM.new
    end

    describe "#execute" do
      it "raise Whitespace::Halt" do
        expect { End.new(@vm).execute }.must_raise Whitespace::Halt
      end
    end
  end
end
