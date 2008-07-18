require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe UserTags, "index action" do
  before(:each) do
    dispatch_to(UserTags, :index)
  end
end