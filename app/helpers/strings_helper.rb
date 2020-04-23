module StringsHelper
  require "uri"

  def downcase_with_underscores(string)
    string.downcase.tr(" ", "_")
  end

  def encode(string)
    URI.encode_www_form_component(string)
  end
end
