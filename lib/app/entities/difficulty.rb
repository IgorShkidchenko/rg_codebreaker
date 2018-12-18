# frozen_string_literal: true

module Codebreaker
  class Difficulty
    attr_reader :level

    DIFFICULTIES = {
      easy: {
        hints: 2,
        attempts: 15,
        level: 'easy'
      },

      medium: {
        hints: 1,
        attempts: 10,
        level: 'medium'
      },

      hell: {
        hints: 1,
        attempts: 5,
        level: 'hell'
      }
    }.freeze

    def initialize(input)
      @level = DIFFICULTIES[input]
    end

    def self.find(input)
      input_as_key = input.to_sym
      return unless DIFFICULTIES.key?(input_as_key)

      new(input_as_key)
    end
  end
end
