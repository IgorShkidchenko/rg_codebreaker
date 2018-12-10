# frozen_string_literal: true

class Game
  attr_reader :hints, :attempts, :breaker_numbers

  GUESSES = { place: '+', presence: '-', all_guessed: ['+', '+', '+', '+'] }.freeze
  CODE_SIZE = 4

  def initialize(attempts, hints)
    @breaker_numbers = generate_random_code
    @breaker_numbers_copy = @breaker_numbers.clone.shuffle
    @hints = hints
    @attempts = attempts
  end

  def start(user_input)
    @attempts -= 1
    @game_numbers = { code: @breaker_numbers.clone, input: user_input }
    collect_place_guess + collect_presence_guess
  end

  def hint
    return if @hints.zero?

    @hints -= 1
    @breaker_numbers_copy.pop
  end

  def win?(result)
    GUESSES[:all_guessed] == result
  end

  def lose?
    @attempts.zero?
  end

  private

  def collect_place_guess
    @game_numbers[:input].map.with_index do |user_num, index|
      if @game_numbers[:code][index] == user_num
        @game_numbers[:code][index] = nil
        @game_numbers[:input][index] = nil
        GUESSES[:place]
      end
    end.compact
  end

  def collect_presence_guess
    @game_numbers[:input].compact.map do |user_num|
      if @game_numbers[:code].include?(user_num)
        @game_numbers[:code].delete_at(@game_numbers[:code].index(user_num))
        GUESSES[:presence]
      end
    end.compact
  end

  def generate_random_code
    Array.new(CODE_SIZE) { rand(1..6) }
  end
end
