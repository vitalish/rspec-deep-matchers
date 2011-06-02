module RSpec
  module Matchers

    class DeepEql

      def initialize(expectation)
        @expectation = expectation
      end

      def matches?(target)
        case @expectation
        when Hash
          target.is_a?(Hash) &&
          target.keys.count.should == @expectation.keys.count &&
          @expectation.keys.each do |key|
            target.has_key?(key) &&
            (target[key].should DeepEql.new(@expectation[key]))
          end
        when Array
          target.is_a?(Array) &&
          target.count.should == @expectation.count &&
          @expectation.each_index do |index|
            target[index].should DeepEql.new(@expectation[index])
          end
        else
          target.should == @expectation
        end
      end

      def failure_message_for_should
        "expected #{@employee} to report to #{@manager}"
      end
    end

    def deep_eql(expected)
      DeepEql.new(expected)
    end
  end
end
