# frozen_string_literal: true

class Navigator < ValidatableEntity
  attr_reader :input, :errors

  def initialize(input)
    super()
    @input = input
  end

  def validate
    @errors << I18n.t('invalid.include_error') unless check_include?(@input, Console::COMMANDS.values)
  end
end
