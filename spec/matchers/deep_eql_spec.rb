require 'spec_helper'

describe 'deep_eql' do

  context "should" do

    it "match hash with differen key order" do
      actual = {:yes => 'yes', :no => 'no'}
      expect = {:no => 'no', :yes => 'yes'}
      actual.should deep_eql(expect)
    end

    it "match hash with same key order" do
      actual = {:yes => 'yes', :no => 'no'}
      expect = {:yes => 'yes', :no => 'no'}
      actual.should deep_eql(expect)
    end

    context "match nested hash" do

      it "with differen key order" do
        actual = {:yes => 'yes', :no => {:label => "name", :name => "Name"} }
        expect = {:no => {:label => "name", :name => "Name"}, :yes => 'yes'}
        actual.should deep_eql(expect)
      end

      it "with differen key order in nested hashes" do
        actual = {:yes => 'yes', :no => {:label => "name", :name => "Name"} }
        expect = {:no => {:name => "Name", :label => "name"}, :yes => 'yes'}
        actual.should deep_eql(expect)
      end

      it "with 3 levels" do
        actual = {:yes => 'yes', :no => {:label => "name", :name => {:first_name => "John", :last_name => "Smith"} } }
        expect = {:no => {:name => {:first_name => "John", :last_name => "Smith"}, :label => "name"}, :yes => 'yes'}
        actual.should deep_eql(expect)
      end

    end

  end

  context "should not" do

    it "match hash with differen key number" do
      actual = {:yes => 'yes', :no => 'no'}
      expect = {:yes => 'yes', :no => 'no', :maybe =>'maybe'}
      actual.should_not deep_eql(expect)
    end

    it "match hash with differen key number" do
      actual = {:yes => 'yes', :no => 'no', :maybe =>'maybe'}
      expect = {:yes => 'yes', :no => 'no'}
      actual.should_not deep_eql(expect)
    end

    it "match hash with differen value" do
      actual = {:yes => 'yes', :no => 'maybe'}
      expect = {:yes => 'yes', :no => 'no'}
      actual.should_not deep_eql(expect)
    end

  end

  it "should match hash" do
    actual = {:yo => 'yo', :no => 'no'}
    expect = {:no => 'no', :yo => 'yo'}
    actual.should deep_eql(expect)
  end



end
