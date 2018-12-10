# frozen_string_literal: true

class Guess < ValidatableEntity
  attr_reader :input, :errors

  VALID_NUMBERS = Game::INCLUDE_IN_GAME_NUMBERS.map(&:to_s)
  HINT = 'hint'

  def initialize(input)
    @input = input
    @errors = []
  end

  def validate
    return if input_hint?

    @errors << I18n.t('exceptions.include_error') unless check_numbers?(@input, VALID_NUMBERS)
    @errors << I18n.t('exceptions.size_error') unless check_size?(@input, Game::CODE_SIZE)
  end

  def valid?
    @errors.empty?
  end

  def make_array_of_numbers
    @input.chars.map(&:to_i)
  end

  private

  def input_hint?
    @input == HINT
  end
end
