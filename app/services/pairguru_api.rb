class PairguruAPI
  include HTTParty
  include StringsHelper

  base_uri "pairguru-api.herokuapp.com"

  def initialize(title)
    @title = title
  end

  def movie
    title = encode(@title)
    self.class.get("/api/v1/movies/#{title}")
  end

  def poster
    title = downcase_with_underscores(@title)
    "https://pairguru-api.herokuapp.com/#{title}.jpg"
  end
end
