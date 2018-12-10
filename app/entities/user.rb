# frozen_string_literal: true

class User < ValidatableEntity
  attr_reader :name

  VALID_NAME_SIZE = (3..20).freeze

  def initialize(name)
    @name = name
  end

  def validate
    check_cover?(@name, VALID_NAME_SIZE)
  end
end
