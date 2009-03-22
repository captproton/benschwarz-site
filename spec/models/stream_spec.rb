require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Stream do

  describe "validations" do
    
    it "should be valid with valid attributes" do
      Stream.gen.should(be_valid)
    end
    
    it "should require a title" do
      pending
    end
    
    it "should require a permalink" do
      pending
    end
  end
  
  describe "hooks" do
    
    it "should create a permalink automagically" do
      Stream.gen.permalink.should_not be_nil
    end
    
    it "should create a permalink based on the title" do
      @stream = Stream.gen
      @stream.permalink.should == @stream.title.gsub(/\s+/, '-')
    end
  end
end