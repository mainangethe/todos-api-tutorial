# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id         :uuid             not null, primary key
#  name       :string
#  done       :boolean
#  todo_id    :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'Associations' do
    # ensure an item record belongs to a single to-do record
    it { should belong_to(:todo) }
  end

  context 'Validations' do
    # ensure column name is present before saving
    it { should validate_presence_of(:name) }
  end
end
