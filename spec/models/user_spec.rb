require 'rails_helper'

RSpec.describe User, type: :model do
  context "Associations" do
    # ensure User model has a 1:m r/ship with Todo model
    it { should have_many(:todos) }
  end

  context "Validations" do
    # ensure name, email, and password_digest are present before save
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
end
