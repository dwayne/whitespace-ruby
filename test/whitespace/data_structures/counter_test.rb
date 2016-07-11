require "test_helper"

module Whitespace
  describe Counter do
    before do
      @counter = Counter.new
    end

    it "is initially 0" do
      expect(@counter.to_int).must_equal 0
    end

    describe "#increment" do
      it "increases its value by 1" do
        @counter.increment

        expect(@counter.to_int).must_equal 1
      end
    end

    describe "#change_to" do
      describe "when the value is non-negative" do
        it "changes the counter's value to the given value" do
          @counter.change_to 5

          expect(@counter.to_int).must_equal 5
        end
      end

      describe "when the value is negative" do
        it "raises ArgumentError" do
          expect { @counter.change_to -1 }.must_raise ArgumentError
        end
      end
    end
  end
end
