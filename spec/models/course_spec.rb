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
require 'rails_helper'

RSpec.describe Course do
  it 'has the correct non-string column types' do
    columns = ActiveRecord::Base.connection.columns(:courses)

    expect(columns.find { |c| c.name == 'credit_hours' }.sql_type).to eq 'integer'
  end

  it 'has seeds' do
    load Rails.root.join('db/seeds.rb').to_s

    expect(described_class.count).to eq 5
    expect(described_class.order(:code).pluck(:name, :code, :credit_hours, :professor))
      .to eq [['Intro to Computer Science', 'CS101', 3, 'Dr. Alice Johnson'],
              ['English Literature', 'ENG201', 3, 'Dr. Carol White'],
              ['Calculus I', 'MATH101', 4, 'Dr. Bob Smith'],
              ['Physics I', 'PHYS101', 4, 'Dr. David Brown'],
              ['Introduction to Psychology', 'PSY101', 3, 'Dr. Emily Davis']]
  end
end
