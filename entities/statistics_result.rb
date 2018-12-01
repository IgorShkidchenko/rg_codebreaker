# frozen_string_literal: true

class StatisticsResult
  attr_reader :left_hints, :left_attempts, :level, :name, :all_attempts, :all_hints

  def initialize(user, left_attempts, left_hints)
    @name = user.name
    @left_hints = left_hints
    @left_attempts = left_attempts
    @level = user.difficult[:level]
    @all_attempts = user.difficult[:attempts]
    @all_hints = user.difficult[:hints]
  end
end
