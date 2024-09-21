# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let!(:course) { create(:course) }

    it 'returns a success response' do
      get :show, params: { id: course }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get :show, params: { id: course }
      expect(response).to render_template(:show)
    end
  end
end
