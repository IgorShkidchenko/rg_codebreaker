# frozen_string_literal: true

module Validator
  def validate_choice
    choice = gets.chomp.downcase
    return choice if %w[rules play table weather save exit].include?(choice)

    puts "I dont have '#{choice}' command".red
    validate_choice
  end

  def validate_name
    name = gets.chomp
    return FFaker::Name.name if name == 'random'

    puts 'Name should be empty'.red if name.empty?
    name.empty? ? validate_name : name.capitalize
  end

  def validate_guess
    puts "You need to enter 'hint' or four numbers between 1 and 6.".yellow
    guess = gets.chomp.downcase
    return guess if guess == 'hint'

    guess.chars.each { |guess_char| return validate_guess unless %w[1 2 3 4 5 6].include? guess_char }
    return validate_guess if guess.size != 4

    guess
  end

  def validate_difficult
    select = gets.chomp.downcase
    return select if %w[easy medium hard].include? select

    puts "I dont have '#{select}' level".red
    validate_difficult
  end
end
