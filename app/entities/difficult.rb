# frozen_string_literal: true

class Difficult < ValidatableEntity
  attr_reader :level

  DIFFICULTS = { easy: { hints: 2, attempts: 15, level: 'easy' },
                 medium: { hints: 1, attempts: 10, level: 'medium' },
                 hell: { hints: 1, attempts: 5, level: 'hell' } }.freeze

  def initialize(input)
    @level = DIFFICULTS[input]
  end

  def self.find(input)
    input_as_key = input.to_sym
    return unless DIFFICULTS.key?(input_as_key)

    new(input_as_key)
  end
end
