# frozen_string_literal: true

class Difficult < ValidatableEntity
  attr_reader :level, :errors

  LEVELS = { easy: 'easy',
             medium: 'medium',
             hell: 'hell' }.freeze

  DIFFICULTS = { easy: { hints: 2, attempts: 15, level: LEVELS[:easy] },
                 medium: { hints: 1, attempts: 10, level: LEVELS[:medium] },
                 hell: { hints: 1, attempts: 5, level: LEVELS[:hell] } }.freeze

  def initialize(input)
    @input = input
    @errors = []
  end

  def validate
    @errors << I18n.t('exceptions.include_error') unless check_include?(@input, LEVELS.values)
  end

  def valid?
    @errors.empty?
  end

  def select_difficult
    case @input
    when LEVELS[:easy] then @level = DIFFICULTS[:easy]
    when LEVELS[:medium] then @level = DIFFICULTS[:medium]
    when LEVELS[:hell] then @level = DIFFICULTS[:hell]
    end
  end
end
