require 'spec_helper'

describe Category do
  before(:each) do
    @valid_attributes = {
      :category_id => 1,
      :name => "value for name",
      :parent_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Category.create!(@valid_attributes)
  end
end
