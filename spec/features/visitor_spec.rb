# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Visitor Features' do
  let!(:course_one) do
    create(:course, name: 'Course One', code: 'Code One', credit_hours: 3, professor: 'Professor One')
  end
  let!(:course_two) do
    create(:course, name: 'Course Two', code: 'Code Two', credit_hours: 4, professor: 'Professor Two')
  end

  feature 'Browse Courses' do
    scenario 'Viewing the course index page content' do
      visit courses_path

      expect(page).to have_css('h1', text: 'Course List')
      within('table') do
        within('thead') do
          within('tr') do
            expect(page).to have_css('th', text: 'Name')
            expect(page).to have_css('th', text: 'Code')
            expect(page).to have_css('th', exact_text: '', count: 1)
          end
        end
        within('tbody') do
          expect(page).to have_css('tr', count: 2)

          within('tr:nth-child(1)') do
            expect(page).to have_css('td', text: course_one.name)
            expect(page).to have_css('td', text: course_one.code)
            expect(page).to have_link('Show')
          end

          within('tr:nth-child(2)') do
            expect(page).to have_css('td', text: course_two.name)
            expect(page).to have_css('td', text: course_two.code)
            expect(page).to have_link('Show')
          end
        end
      end
    end

    scenario 'Redirecting from the root page to the courses page' do
      visit root_path

      expect(page).to have_current_path(courses_path, ignore_query: true)
    end
  end

  feature 'View Course Details' do
    scenario 'Viewing a course show page content' do
      visit course_path(course_one)

      expect(page).to have_css('h1', text: "#{course_one.code}: #{course_one.name}")
      expect(page).to have_css('ul', count: 1)
      expect(page).to have_css('ul li', count: 2)
      expect(page).to have_css('li', text: "Credit Hours: #{course_one.credit_hours}")
      expect(page).to have_css('li', text: "Professor: #{course_one.professor}")
      expect(page).to have_link('Back to Course List')
    end

    scenario 'Navigating to a course show page from the index page' do
      visit courses_path

      click_on 'Show', match: :first

      expect(page).to have_current_path(course_path(course_one), ignore_query: true)
    end

    scenario 'Navigating back to the course index page from the show page' do
      visit course_path(course_one)
      click_on 'Back to Course List'

      expect(page).to have_current_path(courses_path, ignore_query: true)
    end
  end
end
