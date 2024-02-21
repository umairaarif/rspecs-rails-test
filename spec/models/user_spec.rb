require 'rails_helper'

RSpec.describe User, type: :model do
  subject { 
    described_class.new(email: 'example@example.com',
                       password: "123123")
  }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it 'is valid without a description' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
