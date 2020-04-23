class Api::MoviesController < ApplicationController
  def list
    movies = Movie.all

    respond_with_json(movies)
  end
end
