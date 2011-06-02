module RSpec
  module Matchers

    def deep_eql(expected)
      DeepEql.new(expected)
    end

    class DeepEql

      def initialize(expectation)
        @expectation = expectation
      end

      def matches?(target)
        p target
        p @expectation
        @target = target
        case @expectation
        when Hash
          @target.is_a?(Hash) &&
          @target.keys.count == @expectation.keys.count &&
          @expectation.keys.each do |key|
            @target.has_key?(key) &&
            DeepEql.new(@expectation[key]).matches?(@target[key])
          end
        when Array
          @target.is_a?(Array) &&
          @target.count == @expectation.count &&
          @expectation.each_index do |index|
            DeepEql.new(@expectation[index]).matches?(@target[index])
          end
        else
          @target == @expectation
        end
      end

      def failure_message_for_should
        "expected #{@employee} to report to #{@manager}"
      end

      def failure_message_for_should_not
        "expected #{@target.inspect} not to be in Zone #{@expectation.inspect}"
      end
    end

  end
end
