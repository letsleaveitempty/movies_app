require "rails_helper"
require "response_helper"

describe Api::MoviesController do
  let!(:genres) { create_list(:genre, 5, :with_movies) }
  let(:movie) { Movie.last }

  describe "#movie_list" do
    it "responds successfully" do
      get :movie_list, format: "json"

      expect(response).to be_successful
    end

    it "returns a list of movies" do
      get :movie_list, format: "json"

      expect(parsed_response.count).to eql(25)
    end

    it "returns id and title of each movie" do
      get :movie_list, format: "json"

      expect(parsed_response).to include(
        hash_including(id: movie.id, title: movie.title)
      )
    end

    context "with additional genre data" do
      it "returns a list of movies with genres" do
        get :movie_list, params: { genre: true }, format: "json"
        genre = movie.genre

        expect(parsed_response).to include(
          hash_including(
            id: movie.id,
            title: movie.title,
            genre: hash_including(
              id: genre.id,
              name: genre.name,
              number_of_movies: 5
            )
          )
        )
      end
    end
  end

  describe "#movie" do
    context "when given id is invalid" do
      it "returns error message" do
        get :movie, params: { movie_id: "987663" }, format: "json"

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

    context "with additional genre data" do
      it "returns movie and its genre details" do
        get :movie, params: { movie_id: movie.id, genre: true }, format: "json"
        genre = movie.genre

        expect(parsed_response).to eql(
          id: movie.id,
          title: movie.title,
          genre: {
            id: genre.id,
            name: genre.name,
            number_of_movies: 5
          }
        )
      end
    end
  end
end
