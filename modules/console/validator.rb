# frozen_string_literal: true

module Validator
  VALID_NUMBERS = %w[1 2 3 4 5 6].freeze
  VALID_SIZE = 4

  def valid_choice?(choice)
    return false unless choice.is_a? String

    Console::COMMANDS.value?(choice) ? true : Representer.wrong_choice_msg
  end

  def valid_name?(name)
    return false unless name.is_a? String

    (3..20).cover?(name.size) ? true : Representer.wrong_name_msg
  end

  def valid_difficult?(difficult)
    return false unless difficult.is_a? String

    User::LEVELS.value?(difficult) ? true : Representer.wrong_level_msg
  end

  def valid_guess?(guess)
    return false unless guess.is_a? String
    return Representer.wrong_guess_msg if guess.size != VALID_SIZE
    return true if guess == Console::HINT

    guess.chars.each { |guess_char| return Representer.wrong_guess_msg unless VALID_NUMBERS.include? guess_char }
    true
  end
end
