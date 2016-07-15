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

    describe "::is_ascii?" do
      it "returns true if the value is within a certain subset of the " \
          "ASCII character set" do
        [10, 13, 32, 65, 127].each do |v|
          expect(Util.is_ascii?(v)).must_equal true
        end
      end

      it "returns false if the value is not within a certain subset of the " \
          "ASCII character set" do
        [-10, 0, 31, 128, 255, 1023, 1000000000].each do |v|
          expect(Util.is_ascii?(v)).must_equal false
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

    describe "::is_label?" do
      it "returns true if the value is a label" do
        [" ", "    ", "\t", "\t\t\t\t", "  \t \t\t \t"].each do |v|
          expect(Util.is_label?(v)).must_equal true
        end
      end

      it "returns false if the value is not a label" do
        ["", "\n", 1, :x].each do |v|
          expect(Util.is_label?(v)).must_equal false
        end
      end
    end

    describe "::find_label" do
      describe "when the label doesn't exist" do
        it "raises Whitespace::LabelError" do
          instructions = [
            "instruction 1",
            "instruction 2",
            ISA::Label.new(:vm, "  "),
            "instruction 4"
          ]

          e = expect { Util.find_label(instructions, " ") }.must_raise \
            Whitespace::LabelError
          expect(e.message).must_match /missing: " "/
        end
      end

      describe "when the label does exist" do
        it "returns the index of the label" do
          instructions = [
            "instruction 1",
            ISA::Label.new(:vm, " "),
            "instruction 3",
            "instruction 4"
          ]

          expect(Util.find_label(instructions, " ")).must_equal 1
        end
      end
    end
  end
end
