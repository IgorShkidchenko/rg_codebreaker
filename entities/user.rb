# frozen_string_literal: true

class User
  attr_reader :name, :difficult

  def initialize(name, difficult)
    @name = name
    @difficult = difficult
  end
end
