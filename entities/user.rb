# frozen_string_literal: true

class User
  attr_reader :name, :difficult
  include Validator

  LEVELS = { easy: 'easy', medium: 'medium', hell: 'hell' }.freeze
  DIFFICULTS = { easy: { hints: 2, attempts: 15, level: LEVELS[:easy] },
                 medium: { hints: 1, attempts: 10, level: LEVELS[:medium] },
                 hell: { hints: 1, attempts: 5, level: LEVELS[:hell] } }.freeze

  def initialize
    @name = select_name
    @difficult = select_difficult
  end

  def select_name
    Representer.what_name_msg
    name = user_input until valid_name?(name)
    name
  end

  def select_difficult
    Representer.select_difficult_msg
    difficult = user_input until valid_difficult?(difficult)
    case difficult
    when LEVELS[:easy] then DIFFICULTS[:easy]
    when LEVELS[:medium] then DIFFICULTS[:medium]
    when LEVELS[:hell] then DIFFICULTS[:hell]
    end
  end

  def user_input
    input = gets.chomp.downcase
    input == Console::EXIT ? Representer.goodbye : input
  end
end
