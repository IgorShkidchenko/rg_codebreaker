# frozen_string_literal: true

module Validator
  include ValidatorsTexts

  def validated_choice
    choice = gets.chomp.downcase
    until %w[rules start stats exit].include? choice
      WRONG_COMMAND_MSG.call(choice)
      what_next
      choice = gets.chomp.downcase
    end
    choice
  end
  
  def validated_name
    name = gets.chomp.downcase
    return Faker::Name.name if name == 'random'
    return GOODBYE_MSG.call if name == 'exit'
    return name.capitalize if (3..20).cover? name.size

    WRONG_NAME_MSG.call
    validated_name
  end

  def validated_guess
    guess = gets.chomp.downcase
    return guess if guess == 'hint'
    return GOODBYE_MSG.call if guess == 'exit'

    guess.chars.each { |guess_char| return guess_error unless %w[1 2 3 4 5 6].include? guess_char }
    return guess_error if guess.size != 4

    guess
  end

  def guess_error
    WRONG_GUESS_MSG.call
    validated_guess
  end

  def validated_difficult
    SELECT_DIFFICULT_MSG.call
    level = gets.chomp.downcase
    return level if %w[easy medium hell].include? level
    return GOODBYE_MSG.call if level == 'exit'

    WRONG_LEVEL_MSG.call(level)
    validated_difficult
  end
end
