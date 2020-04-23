class Api::GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :number_of_movies

  def number_of_movies
    Genre.find(object.id).movies.count
  end
end
