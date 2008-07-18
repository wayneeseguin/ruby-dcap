require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe UserVotes, "index action" do
  before(:each) do
    dispatch_to(UserVotes, :index)
  end
end