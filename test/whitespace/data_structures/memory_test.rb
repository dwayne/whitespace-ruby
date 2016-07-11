require "test_helper"

module Whitespace
  describe Memory do
    before do
      @memory = Memory.new
    end

    describe "how values are accessed" do
      describe "when the given address exists" do
        it "returns the value" do
          @memory[:address] = :value

          expect(@memory[:address]).must_equal :value
        end
      end

      describe "when the given address does not exist" do
        it "raises Whitespace::AddressError" do
          expect { @memory[:address] }.must_raise AddressError
        end
      end
    end
  end
end
