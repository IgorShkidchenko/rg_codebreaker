# frozen_string_literal: true

module Validator
  def validated_choice
    choice = gets.chomp.downcase
    return choice if %w[rules start stats exit].include?(choice)

    puts "You have passed unexpected command '#{choice}'. Please choose one from listed commands".red
    what_next
    validated_choice
  end

  def validated_name
    name = gets.chomp.downcase
    return FFaker::Name.name if name == 'random'
    return name.capitalize if name.size > 2 && name.size < 21
    return puts 'Goodbye'.pink if name == 'exit'

    puts 'Name must be from 3 to 20 characters'.red
    validated_name
  end

  def validated_guess
    guess = gets.chomp.downcase
    return guess if guess == 'hint'
    return puts 'Goodbye'.pink if guess == 'exit'

    guess.chars.each { |guess_char| return guess_error unless %w[1 2 3 4 5 6].include? guess_char }
    return guess_error if guess.size != 4

    guess
  end

  def guess_error
    puts "You need to enter 'hint' or four numbers between 1 and 6.".red
    validated_guess
  end

  def validated_difficult
    puts 'Select difficulty: '.yellow + 'easy, '.green + 'medium, '.pink + 'hell'.red
    level = gets.chomp.downcase
    return level if %w[easy medium hell].include? level
    return puts 'Goodbye'.pink if level == 'exit'

    puts "I dont have '#{level}' level, try one more time".red
    validated_difficult
  end
end
