# frozen_string_literal: true

class Difficult
  attr_reader :level
  include Validator

  LEVELS = { easy: 'easy', medium: 'medium', hell: 'hell' }.freeze
  DIFFICULTS = { easy: { hints: 2, attempts: 15, level: LEVELS[:easy] },
                 medium: { hints: 1, attempts: 10, level: LEVELS[:medium] },
                 hell: { hints: 1, attempts: 5, level: LEVELS[:hell] } }.freeze

  def initialize(input)
    @input = input
    @level = nil
  end

  def validate_level
    check_include?(@input, LEVELS.values) ? true : Representer.wrong_level_msg
  end

  def select_difficult
    case @input
    when LEVELS[:easy] then @level = DIFFICULTS[:easy]
    when LEVELS[:medium] then @level = DIFFICULTS[:medium]
    when LEVELS[:hell] then @level = DIFFICULTS[:hell]
    end
  end
end
