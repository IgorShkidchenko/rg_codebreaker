# frozen_string_literal: true

class Guess
  include Validator

  VALID_NUMBERS = %w[1 2 3 4 5 6].freeze
  VALID_SIZE = 4
  HINT = 'hint'

  def initialize(input)
    @guess = input
  end

  def validate
    return false unless check_class?(@guess, String)
    return true if check_match?(@guess, HINT)

    check_size?(@guess, VALID_SIZE) && check_numbers?(@guess, VALID_NUMBERS) ? true : Representer.wrong_guess_msg
  end
end
