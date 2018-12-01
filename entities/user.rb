# frozen_string_literal: true

class User
  attr_reader :name, :difficult
  include Validator

  def initialize
    @name = validated_name
    @difficult = select_difficult
  end

  private

  def select_difficult
    Representer.select_difficult_msg
    case validated_difficult
    when 'easy' then { hints: 2, attempts: 15, level: 'easy' }
    when 'medium' then { hints: 1, attempts: 10, level: 'medium' }
    when 'hell' then { hints: 1, attempts: 5, level: 'hell' }
    end
  end
end
