# frozen_string_literal: true

module Codebreaker
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
end
