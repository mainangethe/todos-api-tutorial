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

FactoryBot.define do
  factory :item do
    sequence(:name) { |number| "Item_#{number}" }
    done { rand(2) == 1 }

    # associations
    todo
  end
end
