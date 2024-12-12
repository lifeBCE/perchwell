require 'rails_helper'

RSpec.describe Client, type: :model do
  it "ensures a provided name" do
    client = Client.new

    expect(client.valid?).to eq(false)
    expect(client.errors.full_messages).to include("Name can't be blank")
  end

  it 'is valid when name is provides' do
    client = Client.new(name: "test_name")

    expect(client.valid?).to eq(true)
    expect(client.errors.full_messages).to be_empty
  end
end
