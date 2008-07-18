require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe EventTags, "index action" do
  before(:each) do
    dispatch_to(EventTags, :index)
  end
end