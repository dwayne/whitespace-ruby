require "test_helper"

module Whitespace
  describe Stack do
    before do
      @stack = Stack.new
    end

    describe "#push" do
      it "places an element on top the stack" do
        @stack.push :a
        @stack.push :b

        expect(@stack.top).must_equal :b
      end
    end

    describe "#pop" do
      describe "when the stack is empty" do
        it "raises Whitespace::EmptyError" do
          expect { @stack.pop }.must_raise EmptyError
        end
      end

      describe "when the stack is not empty" do
        it "removes and returns the top element" do
          @stack.push :a
          @stack.push :b

          expect(@stack.pop).must_equal :b
          expect(@stack.top).must_equal :a
        end
      end
    end

    describe "#top" do
      describe "when the stack is empty" do
        it "returns nil" do
          expect(@stack.top).must_equal nil
        end
      end

      describe "when the stack is not empty" do
        it "returns the top element" do
          @stack.push :a
          expect(@stack.top).must_equal :a
        end
      end
    end

    describe "#size" do
      it "returns the number of elements on the stack" do
        expect(@stack.size).must_equal 0

        @stack.push :a
        @stack.push :b
        @stack.push :c

        expect(@stack.size).must_equal 3
      end
    end
  end
end
