# frozen_string_literal: true

class Guess
  attr_reader :input
  include Validator

  VALID_NUMBERS = %w[1 2 3 4 5 6].freeze
  VALID_SIZE = 4
  HINT = 'hint'

  def initialize(input)
    @input = input
  end

  def validate
    return false unless check_class?(@input, String)
    return true if check_match?(@input, HINT)

    check_size?(@input, VALID_SIZE) && check_numbers?(@input, VALID_NUMBERS) ? true : Representer.wrong_guess_msg
  end
end
