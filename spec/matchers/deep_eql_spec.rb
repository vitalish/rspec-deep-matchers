require 'spec_helper'
require 'rspec/matchers'

describe 'deep_eql' do
  it "does something" do
    actual = {:yo => 'yo', :no => 'no'}
    expact = {:no => 'no', :yo => 'yo'}
    actual.should deep_eql(expact)
  end

end
