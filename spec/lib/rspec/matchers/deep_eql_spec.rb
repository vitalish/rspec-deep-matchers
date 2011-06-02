require 'spec_helper'

describe 'deep_eql' do

  context "should match" do
    after(:each) do
      @actual.should deep_eql(@expect)
    end

    it "eql strings" do
      @actual = "true"
      @expect = "true"
    end

    context "arrays" do

      it "that are eql" do
        @actual = [1,2,3]
        @expect = [1,2,3]
      end

      it "with hash with different order" do
        @actual = [1, 2, {"one" => 1, "two" => 2, "three" => 3 }]
        @expect = [1, 2, {"three" => 3, "one" => 1, "two" => 2 }]
      end

    end

    context "hash with" do

      it "differen key order" do
        @actual = {:yes => 'yes', :no => 'no'}
        @expect = {:no => 'no', :yes => 'yes'}
      end

      it "same key order" do
        @actual = {:yes => 'yes', :no => 'no'}
        @expect = {:yes => 'yes', :no => 'no'}
      end

      context "nested hash" do

        it "with differen key order" do
          @actual = {:yes => 'yes', :no => {:label => "name", :name => "Name"} }
          @expect = {:no => {:label => "name", :name => "Name"}, :yes => 'yes'}
        end

        it "with differen key order in nested hashes" do
          @actual = {:yes => 'yes', :no => {:label => "name", :name => "Name"} }
          @expect = {:no => {:name => "Name", :label => "name"}, :yes => 'yes'}
        end

        it "with 3 levels" do
          @actual = {:yes => 'yes', :no => {:label => "name", :name => {:first_name => "John", :last_name => "Smith"} } }
          @expect = {:no => {:name => {:first_name => "John", :last_name => "Smith"}, :label => "name"}, :yes => 'yes'}
        end

      end

      context "array" do

        it "with strict order" do
          @actual = {:yes => 'yes', :maybe => [:true, :false] }
          @expect = {:maybe => [:true, :false], :yes => 'yes'}
        end

        it "2 level" do
          @actual = {:yes => 'yes', :maybe => [[:true, :false], [:yes, :no]]   }
          @expect = {:maybe => [[:true, :false], [:yes, :no]], :yes => 'yes'}
        end

        it "that has hash with different order" do
          @actual = {:yes => 'yes', :maybe => [{:true => "yes", :false => "no"}, [:yes, :no]]   }
          @expect = {:maybe => [{:false => "no", :true => "yes"}, [:yes, :no]], :yes => 'yes'}
        end

      end

    end


  end


  context "should not match" do

    after(:each) do
      @actual.should_not deep_eql(@expect)
    end

    it "different strings" do
      @actual = "true"
      @expect = "false"
    end

    context "hash with" do

      it "differen key number ( @actual < @expect)" do
        @actual = {:yes => 'yes', :no => 'no'}
        @expect = {:yes => 'yes', :no => 'no', :maybe =>'maybe'}
      end

      it "differen key number ( @actual > @expect)" do
        @actual = {:yes => 'yes', :no => 'no', :maybe =>'maybe'}
        @expect = {:yes => 'yes', :no => 'no'}
      end

      it "differen value" do
        @actual = {:yes => 'yes', :no => 'maybe'}
        @expect = {:yes => 'yes', :no => 'no'}
      end

    end

    context "array with" do

      it "different size ( @actual < @expect)" do
        @actual = [1,2,3]
        @expect = [1,2,3,4]
      end

      it "different size ( @actual > @expect)" do
        @actual = [1,2,3,4]
        @expect = [1,2,3]
      end

      it "differen value" do
        @actual = [1,2,4]
        @expect = [1,2,3]
      end

    end


  end

end
