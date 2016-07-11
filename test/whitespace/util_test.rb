require "test_helper"

module Whitespace
  describe Util do
    describe "::is_integer?" do
      it "returns true if the value is an integer" do
        [-1, 0, 1, 1000000000000000000000].each do |v|
          expect(Util.is_integer?(v)).must_equal true
        end
      end

      it "returns false if the value is not an integer" do
        ["1", :x, 3.14].each do |v|
          expect(Util.is_integer?(v)).must_equal false
        end
      end
    end

    describe "::is_binop?" do
      it "returns true for the binary operators :add, :sub, :mul, :div, :mod" do
        [:add, :sub, :mul, :div, :mod].each do |op|
          expect(Util.is_binop?(op)).must_equal true
        end
      end
    end
  end
end
