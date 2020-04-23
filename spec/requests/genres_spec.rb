require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }

  before do
    stub_request(:get, %r{pairguru-api.herokuapp.com/api/v1/movies})
      .to_return(
        body: {}.to_json,
        headers: { content_type: "application/json" }
      )
  end

  describe "genre list" do
    it "displays only related movies" do
      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
    end
  end
end
