require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Source do

  describe "validations" do
    
    it "should be valid with valid attributes" do
      Source.gen.should(be_valid)
    end
  end
end