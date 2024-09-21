# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id           :bigint           not null, primary key
#  code         :string
#  credit_hours :integer
#  name         :string
#  professor    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :course do
    name { 'course' }
  end
end
