class Api::MovieSerializer < ActiveModel::Serializer
  attributes :id, :title

  belongs_to :genre, if: :include_genre

  def include_genre
    return false unless instance_options
    instance_options.dig(:options, :genre)
  end
end
