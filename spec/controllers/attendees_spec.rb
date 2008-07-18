require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Attendees, "index action" do
  before(:each) do
    dispatch_to(Attendees, :index)
  end
end