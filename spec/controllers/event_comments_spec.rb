require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe EventComments, "index action" do
  before(:each) do
    dispatch_to(EventComments, :index)
  end
end