# frozen_string_literal: true

module Difficult
  def select_difficult
    case validated_difficult
    when 'easy' then { hints: 2, attempts: 15, level: 'easy' }
    when 'medium' then { hints: 1, attempts: 10, level: 'medium' }
    when 'hell' then { hints: 1, attempts: 5, level: 'hell' }
    end
  end
end
