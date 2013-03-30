module Deep
  module Matchers

    def deep_eql(expected)
      DeepEql.new(expected)
    end

    class DeepEql

      def initialize(expectation)
        begin
          require 'awesome_print'
          require 'awesome_print/core_ext/kernel'
          @have_ap = true
        rescue Exception => e
          @have_ap = false
        end
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

      def pretty_print(thing)
        if @have_ap
          thing.awesome_inspect(:plain => true)
        else
          thing.inspect
        end
      end

      def failure_message_for_should
        "expected #{pretty_print @target} to be deep_eql with #{pretty_print @expectation}"
      end

      def failure_message_for_should_not
        "expected #{pretty_print @target} not to be in deep_eql with #{pretty_print @expectation}"
      end
    end

  end
end

