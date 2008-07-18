require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe SessionTags, "index action" do
  before(:each) do
    dispatch_to(SessionTags, :index)
  end
end