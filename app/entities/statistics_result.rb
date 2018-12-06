# frozen_string_literal: true

class StatisticsResult
  attr_reader :left_hints, :left_attempts, :all_attempts, :all_hints, :level, :name

  def initialize(name:, difficult:, game:)
    @name = name
    @level = difficult[:level]
    @all_attempts = difficult[:attempts]
    @all_hints = difficult[:hints]
    @left_attempts = game.attempts
    @left_hints = game.hints
  end
end
