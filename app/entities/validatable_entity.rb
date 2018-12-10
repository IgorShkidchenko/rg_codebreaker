# frozen_string_literal: true

class ValidatableEntity
  include Validator

  def validate
    raise NotImplementedError
  end
end
