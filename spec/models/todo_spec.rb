require 'rails_helper'

RSpec.describe Todo, type: :model do
  context "Associations" do
    # ensure Todo model has a 1:m r/ship with the Item model
    it { should have_many(:items).dependent(:destroy) }
  end

  context "Validations" do
    # ensure columns title & created_by are present before saving
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:created_by) }
  end

end
