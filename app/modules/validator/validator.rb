# frozen_string_literal: true

module Validator
  def valid_choice(choice)
    return false unless check_class?(choice, String)

    check_include?(choice, Console::COMMANDS.values) ? true : Representer.wrong_level_msg
  end

  def valid_name(name)
    return false unless check_class?(name, String)

    check_cover?(name, Console::VALID_NAME_SIZE) ? true : Representer.wrong_name_msg
  end

  def valid_difficult(difficult)
    return false unless check_class?(difficult, String)

    check_include?(difficult, Console::LEVELS.values) ? true : Representer.wrong_level_msg
  end

  def check_cover?(input, valid_numbers)
    valid_numbers.cover?(input.size)
  end

  def check_include?(input, checkable_array)
    checkable_array.include?(input)
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
