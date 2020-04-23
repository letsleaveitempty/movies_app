require "rails_helper"
require "response_helper"

describe Api::MoviesController do
  let!(:genres) { create_list(:movie, 5) }

  describe "#list" do
    it 'responds successfully' do
      get :list, format: 'json'

      expect(response).to be_successful
    end

    it 'returns a list of movies' do
      get :list, format: 'json'

      expect(parsed_response.count).to eql(5)
    end

    it 'returns id and title of each movie' do
      get :list, format: 'json'
      movie = Movie.last

      expect(parsed_response).to include(
        { id: movie.id, title: movie.title }
      )
    end
  end
end
