# frozen_string_literal: true

module Validator

  def valid_choice(choice)
    return false unless check_class?(choice, String)

    Console::COMMANDS.value?(choice) ? true : Representer.wrong_choice_msg
  end

  def valid_name(name)
    return false unless check_class?(name, String)

    (3..20).cover?(name.size) ? true : Representer.wrong_name_msg
  end

  def valid_difficult(difficult)
    return false unless check_class?(difficult, String)

    Console::LEVELS.value?(difficult) ? true : Representer.wrong_level_msg
  end

  def check_match?(input, twin)
    input == twin
  end

  def check_class?(input, klass)
    input.is_a? klass
  end

  def check_numbers?(input, numbers)
    input.chars.each { |guess_char| return false unless numbers.include? guess_char }
    true
  end

  def check_size?(input, size)
    input.size == size
  end
end
