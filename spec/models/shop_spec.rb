require 'spec_helper'

describe Shop do
  it "can be instantiated" do
    Shop.new.should be_an_instance_of(Shop)
  end

  it "can be saved successfully" do
    Shop.create.should be_persisted
  end
end