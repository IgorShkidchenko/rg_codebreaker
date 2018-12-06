# frozen_string_literal: true

module Validator
  def check_cover?(cheackable, valid_numbers)
    valid_numbers.cover?(cheackable.size)
  end

  def check_include?(cheackable, collection)
    collection.include?(cheackable)
  end

  def check_match?(cheackable, twin)
    cheackable == twin
  end

  def check_size?(cheackable, size)
    cheackable.size == size
  end

  def check_numbers?(cheackable, numbers)
    cheackable.chars.each { |guess_char| return false unless check_include?(guess_char, numbers) }
    true
  end
end
