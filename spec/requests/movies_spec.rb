require "rails_helper"
require 'webmock/rspec'

describe "Movies requests", type: :request do
  before do
    @movie = create(:movie, title: "Test Movie")
    expected_api_response = {
      "data": {
        "id": "6",
        "type": "movie",
        "attributes": {
          "title": "Test Movie",
          "plot": "The aging patriarch of an organized crime...",
          "rating": 9.2,
          "poster": "/godfather.jpg"
        }
      }
    }

    stub_request(:get, %r{pairguru-api.herokuapp.com/api/v1/movies})
      .to_return(
        body: expected_api_response.to_json,
        headers: { content_type: "application/json" }
      )
  end

  describe "index" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "displays additional info" do
      visit "/movies"

      expect(page).to have_content(@movie.title)
      expect(page).to have_content(9.2)
      expect(page).to have_content("The aging patriarch of an organized crime")
      expect(page).to have_xpath(
        "//img[contains(@src, \"pairguru-api.herokuapp.com/test_movie.jpg\")]"
      )
    end
  end

  describe "show" do
    it "displays additional info" do
      visit "/movies/1"

      expect(page).to have_content(@movie.title)
      expect(page).to have_content(9.2)
      expect(page).to have_content("The aging patriarch of an organized crime")
      expect(page).to have_xpath(
        "//img[contains(@src, \"pairguru-api.herokuapp.com/test_movie.jpg\")]"
      )
    end
  end
end
