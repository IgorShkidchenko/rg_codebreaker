# frozen_string_literal: true

module Difficult
  def select_difficult
    case validate_difficult
    when 'easy' then easy
    when 'medium' then medium
    when 'hell' then hell
    end
  end

  def easy
    @hint = 2
    @attempts = 15
    @level = 'easy'
  end

  def medium
    @hint = 1
    @attempts = 10
    @level = 'medium'
  end

  def hell
    @hint = 1
    @attempts = 5
    @level = 'hell'
  end
end
