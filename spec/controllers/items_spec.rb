require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Items, "index action" do
  before(:each) do
    dispatch_to(Items, :index)
  end
end