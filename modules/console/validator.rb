# frozen_string_literal: true

module Validator
  def validated_choice
    loop do
      choice = input
      return choice if %w[rules start stats].include? choice

      Representer.wrong_choice_msg
    end
  end

  def validated_name
    loop do
      name = input
      return name.capitalize if (3..20).cover? name.size

      Representer.wrong_name_msg
    end
  end

  def validated_difficult
    loop do
      difficult = input
      return difficult if %w[easy medium hell].include? difficult

      Representer.wrong_level_msg
    end
  end

  def validated_guess
    guess = input
    return guess if guess == 'hint'
    return guess_error if guess.size != 4

    guess.chars.each { |guess_char| return guess_error unless %w[1 2 3 4 5 6].include? guess_char }
    guess
  end

  private

  def guess_error
    Representer.wrong_guess_msg
    validated_guess
  end

  def input
    input = gets.chomp.downcase
    input == 'exit' ? Representer.goodbye : input
  end
end
