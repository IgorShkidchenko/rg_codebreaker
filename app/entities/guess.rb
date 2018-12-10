# frozen_string_literal: true

class Guess < ValidatableEntity
  attr_reader :input

  VALID_NUMBERS = Game::INCLUDE_IN_GAME_NUMBERS.map(&:to_s)
  EXCEPTIONS = [SizeError, IncludeError].freeze
  HINT = 'hint'

  def initialize(input)
    @input = input
  end

  def validate
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
