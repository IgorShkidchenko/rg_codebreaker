# frozen_string_literal: true

module Validator
  def check_cover?(cheackable, valid_numbers)
    valid_numbers.cover?(cheackable.size)
  end

  def check_include?(cheackable, valid_collection)
    valid_collection.include?(cheackable)
  end

  def check_size?(cheackable, valid_size)
    cheackable.size == valid_size
  end

  def check_numbers?(cheackable, valid_numbers)
    cheackable.chars.each { |guess_char| return false unless check_include?(guess_char, valid_numbers) }
    true
  end
end
