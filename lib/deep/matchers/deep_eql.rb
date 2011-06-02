module Deep
  module Matchers

    def deep_eql(expected)
      DeepEql.new(expected)
    end

    class DeepEql

      def initialize(expectation)
        @expectation = expectation
      end

      def matches?(target)
        result = true
        @target = target
        case @expectation
        when Hash
          result &&= @target.is_a?(Hash) && @target.keys.count == @expectation.keys.count
          @expectation.keys.each do |key|
            result &&= @target.has_key?(key) &&
            DeepEql.new(@expectation[key]).matches?(@target[key])
          end
        when Array
          result &&= @target.is_a?(Array) && @target.count == @expectation.count
          @expectation.each_index do |index|
            result &&= DeepEql.new(@expectation[index]).matches?(@target[index])
          end
        else
          result &&= @target == @expectation
        end
        result
      end

      def failure_message_for_should
        "expected #{@target.inspect} to be deep_eql with #{@expectation.inspect}"
      end

      def failure_message_for_should_not
        "expected #{@target.inspect} not to be in deep_eql with #{@expectation.inspect}"
      end
    end

  end
end
