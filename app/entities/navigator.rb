# frozen_string_literal: true

class Navigator < ValidatableEntity
  attr_reader :input, :errors

  def initialize(input)
    @input = input
    @errors = []
  end

  def validate
    @errors << I18n.t('exceptions.include_error') unless check_include?(@input, Console::COMMANDS.values)
  end

  def valid?
    @errors.empty?
  end
end
