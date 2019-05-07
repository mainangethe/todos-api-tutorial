# frozen_string_literal: true

# == Schema Information
#
# Table name: todos
#
#  id         :uuid             not null, primary key
#  title      :string
#  created_by :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :todo do
    sequence(:title) { |number| "title_#{number}" }
    created_by { Faker::Name.name_with_middle }
  end
end
