class TitleBracketsValidator
  require "byebug"
  BRACKETS = {
    "(" => ")",
    "[" => "]",
    "{" => "}"
  }.freeze

  def initialize(title)
    @title = title
  end

  def validate(title)
    string_brackets = title.title.gsub(/[^\(\)\{\}\[\]]/, "")
    return true if string_brackets.empty?

    check_brackets(string_brackets)
  end

  def check_brackets(string_brackets)
    open_brackets = []

    string_brackets.each_char do |bracket|
      if BRACKETS.key?(bracket)
        open_brackets << bracket
      elsif BRACKETS.value?(bracket)
        return false if open_brackets.empty?
        BRACKETS[open_brackets.pop] == bracket
      end
    end

    open_brackets.empty?
  end
end
