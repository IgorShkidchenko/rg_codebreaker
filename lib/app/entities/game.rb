# frozen_string_literal: true

module Codebreaker
  class Game
    attr_reader :hints, :attempts

    INCLUDE_IN_GAME_NUMBERS = (1..6).freeze
    CODE_SIZE = 4

    GUESS_PLACE = '+'
    GUESS_PRESENCE = '-'

    def initialize(difficulty)
      @breaker_numbers = generate_random_code
      @breaker_numbers_copy = @breaker_numbers.clone.shuffle
      @hints = difficulty.level[:hints]
      @attempts = difficulty.level[:attempts]
    end

    def start_round(user_input)
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
      @breaker_numbers == result
    end

    def lose?(result)
      @attempts == 1 && @breaker_numbers != result
    end

    private

    def collect_place_guess
      @game_numbers[:input].map.with_index do |user_num, index|
        next if @game_numbers[:code][index] != user_num

        @game_numbers[:code][index] = nil
        @game_numbers[:input][index] = nil
        GUESS_PLACE
      end.compact
    end

    def collect_presence_guess
      @game_numbers[:input].compact.map do |user_num|
        next unless @game_numbers[:code].include?(user_num)

        @game_numbers[:code].delete_at(@game_numbers[:code].index(user_num))
        GUESS_PRESENCE
      end.compact
    end

    def generate_random_code
      Array.new(CODE_SIZE) { rand(INCLUDE_IN_GAME_NUMBERS) }
    end
  end
end
