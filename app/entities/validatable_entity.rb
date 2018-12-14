# frozen_string_literal: true

class ValidatableEntity
  include Validator

  def initialize
    @errors = []
  end

  def validate
    raise NotImplementedError
  end

  def valid?
    validate
    @errors.empty?
  end
end
