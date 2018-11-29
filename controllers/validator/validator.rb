# frozen_string_literal: true

module Validator
  include ValidatorsTexts

  def validated_choice
    choice = gets.chomp.downcase
    return choice if %w[rules start stats exit].include? choice

    choice_error(choice)
  end

  def validated_name
    name = gets.chomp.downcase
    return Faker::Name.name if name == 'random'
    return puts GOODBYE_MSG if name == 'exit'
    return name.capitalize if (3..20).cover? name.size

    name_error
  end

  def validated_guess
    guess = gets.chomp.downcase
    return guess if guess == 'hint'
    return puts GOODBYE_MSG if guess == 'exit'

    guess.chars.each { |guess_char| return guess_error unless %w[1 2 3 4 5 6].include? guess_char }
    return guess_error if guess.size != 4

    guess
  end

  def validated_difficult
    puts SELECT_DIFFICULT_MSG
    level = gets.chomp.downcase
    return level if %w[easy medium hell].include? level
    return puts GOODBYE_MSG if level == 'exit'

    difficult_error(level)
  end

  def guess_error
    puts WRONG_GUESS_MSG
    validated_guess
  end

  def choice_error(choice)
    wrong_command_msg(choice)
    what_next
    validated_choice
  end

  def name_error
    puts WRONG_NAME_MSG
    validated_name
  end

  def difficult_error(level)
    wrong_level_msg(level)
    validated_difficult
  end
end
