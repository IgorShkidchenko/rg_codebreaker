# frozen_string_literal: true

class StatisticsResult
  attr_reader :left_hints, :left_attempts, :all_attempts, :all_hints, :level, :name

  def initialize(user:, difficulty:, game:)
    @name = user.name
    @level = difficulty.level[:level]
    @all_attempts = difficulty.level[:attempts]
    @all_hints = difficulty.level[:hints]
    @left_attempts = game.attempts
    @left_hints = game.hints
  end
end
