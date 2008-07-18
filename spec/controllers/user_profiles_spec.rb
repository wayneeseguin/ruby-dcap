require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe UserProfiles, "index action" do
  before(:each) do
    dispatch_to(UserProfiles, :index)
  end
end