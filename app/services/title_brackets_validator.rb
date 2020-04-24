class TitleBracketsValidator < ActiveModel::Validator
  BRACKETS = {
    "(" => ")",
    "[" => "]",
    "{" => "}"
  }.freeze

  def validate(record)
    return if no_brackets(record)
    detect_empty_brackets(record)
    balance_brackets(record)
  end

  private

  def no_brackets(record)
    record.title.gsub(/[^\(\)\{\}\[\]]/, "").empty?
  end

  def detect_empty_brackets(record)
    empty_brackets = []

    BRACKETS.each do |k, v|
      empty_brackets << "#{k}#{v}"
    end

    add_error(record) if empty_brackets.any? { |b| record.title.include?(b) }
  end

  def balance_brackets(record)
    opened_brackets = []

    record.title.each_char do |char|
      if BRACKETS.key?(char)
        opened_brackets << char
      elsif BRACKETS.value?(char)
        add_error(record) if opened_brackets.empty?
        add_error(record) unless BRACKETS[opened_brackets.pop] == char
      end
    end

    add_error(record) unless opened_brackets.empty?
  end

  def add_error(record)
    record.errors.add(:base, "Unbalanced or empty brackets")
  end
end
