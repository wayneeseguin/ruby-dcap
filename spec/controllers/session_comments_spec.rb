require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe SessionComments, "index action" do
  before(:each) do
    dispatch_to(SessionComments, :index)
  end
end