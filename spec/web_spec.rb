require File.join(File.dirname(__FILE__), 'spec_helper')

describe "HTTP Auth" do
  it "should require auth" do
    get '/edit'
    @response.status.should == 401
  end
  
  it "should auth successfully" do
    auth(:get, '/edit')
    @response.status.should == 200
  end
end

describe "response to paths" do
  
  describe 'successful' do
    it "should respond to root" do
      get '/'
      @response.status.should == 200
    end
  end
end