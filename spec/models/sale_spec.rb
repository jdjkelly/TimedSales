require 'spec_helper'

describe Sale do
  it "can be instantiated" do
    Sale.new.should be_an_instance_of(Sale)
  end

  # it "can be saved successfully" do
  #   Sale.create.should be_persisted
  # end
end