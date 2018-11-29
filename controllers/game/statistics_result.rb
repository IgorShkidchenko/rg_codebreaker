# frozen_string_literal: true

class StatisticsResult
  attr_reader :hints, :attempts, :level, :name, :all_attempts

  def initialize(name:, attempts:, hints:, level:)
    @name = name
    @hints = hints
    @attempts = attempts
    @level = level
    case level
    when 'easy' then @all_attempts = 15
    when 'medium' then @all_attempts = 10
    when 'hell' then @all_attempts = 5
    end
  end
end
