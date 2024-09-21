# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes follow resource naming' do
  context 'when routing' do
    specify 'Courses index' do
      expect(get: courses_path).to route_to 'courses#index'
    end

    specify 'Courses show' do
      expect(get: course_path(1)).to route_to controller: 'courses', action: 'show', id: '1'
    end
  end

  context 'when creating path helpers' do
    specify 'courses_path' do
      expect(courses_path).to eq '/courses'
    end

    specify 'course_path' do
      expect(course_path(1)).to eq '/courses/1'
    end
  end
end
