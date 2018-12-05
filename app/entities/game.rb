# frozen_string_literal: true

class Game
  attr_reader :hints, :attempts, :breaker_numbers

  ALL_GUESSED = ['+', '+', '+', '+'].freeze
  WIN = :win
  LOSE = :lose
  GUESSED_THE_PLACE = '+'
  GUESSED_THE_PRESENCE = '-'

  def initialize(attempts, hints)
    @breaker_numbers = generate_random_code
    @breaker_numbers_copy = @breaker_numbers.clone
    @hints = hints
    @attempts = attempts
  end

  def start(user_input)
    @attempts -= 1
    return LOSE if @attempts.zero?

    result = check_guess(user_input).compact.sort!
    result == ALL_GUESSED ? WIN : result
  end

  def hint
    @hints -= 1
    showed = @breaker_numbers_copy.sample
    @breaker_numbers_copy.delete_at(@breaker_numbers_copy.index(showed))
    showed
  end

  private

  def check_guess(user_input)
    checked_numbers = []
    @breaker_numbers.zip(user_input).map do |breaker_num, user_num|
      if breaker_num == user_num
        checked_numbers << user_num
        GUESSED_THE_PLACE
      elsif presence_in_code?(checked_numbers, user_num)
        checked_numbers << user_num
        GUESSED_THE_PRESENCE
      end
    end
  end

  def presence_in_code?(checked_numbers, user_num)
    @breaker_numbers.include?(user_num) && !checked_numbers.include?(user_num)
  end

  def generate_random_code
    Array.new(4) { rand(1..6) }
  end
end
