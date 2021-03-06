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

class Item < ApplicationRecord
  # model association
  belongs_to :todo

  # validations
  validates_presence_of :name
end
