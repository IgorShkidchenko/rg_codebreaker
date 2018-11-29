# frozen_string_literal: true

class Game
  attr_reader :hints, :attempts, :level, :name, :breaker_numbers

  def initialize(name, difficult)
    @breaker_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @breaker_numbers_copy = @breaker_numbers.clone
    @name = name
    @hints = difficult[:hints]
    @attempts = difficult[:attempts]
    @level = difficult[:level]
  end

  def start(guess)
    @attempts -= 1
    return :lose if @attempts.zero?

    user_numbers = guess.chars.map(&:to_i)
    check_guess(@breaker_numbers.zip(user_numbers), user_numbers).compact.sort!
  end

  def check_guess(zip_numbers, user_numbers)
    checked = []
    zip_numbers.map do |breaker_num, user_num|
      if breaker_num == user_num
        checked << user_num if user_numbers.count(breaker_num) > 1
        '+'
      elsif breaker_num != user_num && @breaker_numbers.include?(user_num) && !checked.include?(user_num)
        checked << user_num
        '-'
      end
    end
  end

  def hint
    @hints -= 1
    showed = @breaker_numbers_copy[rand(0...@breaker_numbers_copy.size)]
    @breaker_numbers_copy.delete_at(@breaker_numbers_copy.index(showed))
    showed
  end
end
