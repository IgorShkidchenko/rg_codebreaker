# frozen_string_literal: true

class Guess
  attr_reader :input
  include Validator

  VALID_NUMBERS = %w[1 2 3 4 5 6].freeze
  EXCEPTIONS = [SizeError, IncludeError].freeze
  HINT = 'hint'

  def initialize(input)
    @input = input
  end

  def validate_guess
    return if input_hint?

    check_numbers?(@input, VALID_NUMBERS)
    check_size?(@input, Game::CODE_SIZE)
  end

  def make_array_of_numbers
    @input.chars.map(&:to_i)
  end

  private

  def input_hint?
    @input == HINT
  end
end
