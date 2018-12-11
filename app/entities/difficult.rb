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
    super()
    @input = input
  end

  def validate
    @errors << I18n.t('exceptions.include_error') unless check_include?(@input, LEVELS.values)
  end

  def select_difficult
    @level = DIFFICULTS[@input.to_sym]
  end
end
