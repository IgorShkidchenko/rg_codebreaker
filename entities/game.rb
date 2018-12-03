# frozen_string_literal: true

class Game
  attr_reader :hints, :attempts, :breaker_numbers

  def initialize(difficult)
    @breaker_numbers = Array.new(4) { rand(1..6) }
    @breaker_numbers_copy = @breaker_numbers.clone
    @hints = difficult[:hints]
    @attempts = difficult[:attempts]
  end

  def start(user_input)
    @attempts -= 1
    return :lose if @attempts.zero?

    result = check_guess(user_input).compact.sort!
    result == ['+', '+', '+', '+'] ? :win : result
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
        '+'
      elsif presence_in_code?(checked_numbers, user_num)
        checked_numbers << user_num
        '-'
      end
    end
  end

  def presence_in_code?(checked_numbers, user_num)
    @breaker_numbers.include?(user_num) && !checked_numbers.include?(user_num)
  end
end
