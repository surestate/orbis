require 'spec_helper'

describe "/client_sessions/new" do
  before(:each) do
    render 'client_sessions/new'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/client_sessions/new])
  end
end
