require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe EventSessions, "index action" do
  before(:each) do
    dispatch_to(EventSessions, :index)
  end
end