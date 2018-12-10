# frozen_string_literal: true

module Validator
  include Errors

  def check_cover?(cheackable, valid_numbers)
    raise CoverError unless valid_numbers.cover?(cheackable.size)
  end

  def check_include?(cheackable, valid_collection)
    raise IncludeError unless valid_collection.include?(cheackable)
  end

  def check_size?(cheackable, valid_size)
    raise SizeError unless cheackable.size == valid_size
  end

  def check_numbers?(cheackable, valid_numbers)
    cheackable.chars.each { |guess_char| check_include?(guess_char, valid_numbers) }
  end
end
