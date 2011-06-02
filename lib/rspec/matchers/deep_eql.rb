require 'rspec'
module RSpec
  module Matchers
    def deep_eql(expected)
      Matcher.new :deep_eql, expected do |expectation|
        match do |target|
          case expectation
          when Hash
            target.should be_a(Hash)
            target.keys.count.should == expectation.keys.count
            expectation.keys.each do |key|
              target.should have_key(key)
              target[key].should deep_eql(expectation[key])
            end
          when Array
            target.should be_a(Array)
            target.count.should == expectation.count
            expectation.each_index do |index|
              target[index].should deep_eql(expectation[index])
            end
          else
            target.should == expectation
          end
        end
      end
    end
  end
end
