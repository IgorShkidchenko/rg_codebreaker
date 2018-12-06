# frozen_string_literal: true

class User
  attr_reader :name
  include Validator

  VALID_NAME_SIZE = (3..20).freeze

  def initialize(name)
    @name = name
  end

  def validate_name
    check_cover?(@name, VALID_NAME_SIZE) ? true : Representer.wrong_name_msg
  end
end
