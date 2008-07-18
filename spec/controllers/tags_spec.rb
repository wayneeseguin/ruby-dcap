require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Tags, "index action" do
  before(:each) do
    dispatch_to(Tags, :index)
  end
end