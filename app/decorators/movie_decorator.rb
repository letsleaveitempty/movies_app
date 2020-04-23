class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def poster
    pairguru_api.poster
  end

  def rating
    pairguru_api_movie.dig("data", "attributes", "rating")
  end

  def plot
    pairguru_api_movie.dig("data", "attributes", "plot")
  end

  private

  def pairguru_api
    @pairguru_api = PairguruAPI.new(title)
  end

  def pairguru_api_movie
    @pairguru_api_movie = pairguru_api.movie
  end
end
