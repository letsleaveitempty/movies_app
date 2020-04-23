require "rails_helper"
require "response_helper"

describe Api::MoviesController do
  let!(:genres) { create_list(:movie, 5) }
  let(:movie) { Movie.last }

  describe "#movie_list" do
    it "responds successfully" do
      get :movie_list, format: "json"

      expect(response).to be_successful
    end

    it "returns a list of movies" do
      get :movie_list, format: "json"

      expect(parsed_response.count).to eql(5)
    end

    it "returns id and title of each movie" do
      get :movie_list, format: "json"

      expect(parsed_response).to include(
        id: movie.id, title: movie.title
      )
    end
  end

  describe "#movie" do
    context "when given id is invalid" do
      it 'returns error message' do
        get :movie, params: { movie_id: '987663' }, format: 'json'

        expect(response).not_to be_successful
        expect(parsed_response).to eql(
          error: "Couldn't find Movie with 'id'=987663"
        )
      end
    end

    it "responds successfully" do
      get :movie, params: { movie_id: movie.id }, format: "json"

      expect(response).to be_successful
    end

    it "returns movie details" do
      get :movie, params: { movie_id: movie.id }, format: "json"

      expect(parsed_response).to eql(
        id: movie.id, title: movie.title
      )
    end
  end
end
