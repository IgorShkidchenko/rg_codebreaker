# frozen_string_literal: true

class Console
  attr_reader :user, :game
  include Uploader
  include Validator

  EXIT = 'exit'
  YES = 'yes'
  COMMANDS = { rules: 'rules', start: 'start', stats: 'stats' }.freeze
  LEVELS = { easy: 'easy', medium: 'medium', hell: 'hell' }.freeze
  DIFFICULTS = { easy: { hints: 2, attempts: 15, level: LEVELS[:easy] },
                 medium: { hints: 1, attempts: 10, level: LEVELS[:medium] },
                 hell: { hints: 1, attempts: 5, level: LEVELS[:hell] } }.freeze

  def initialize
    @user = nil
    @game = nil
    Representer.greeting_msg
  end

  def what_next
    Representer.what_next_text
    choice = user_input until valid_choice(choice)
    case choice
    when COMMANDS[:rules] then rules
    when COMMANDS[:stats] then statistics
    when COMMANDS[:start] then registration
    end
  end

  def registration
    @user = User.new(select_name, select_difficult)
    @game = Game.new(@user.difficult[:attempts], @user.difficult[:hints])
    go_game
  end

  def select_name
    Representer.what_name_msg
    name = user_input until valid_name(name)
    name
  end

  def select_difficult
    Representer.select_difficult_msg
    difficult = user_input until valid_difficult(difficult)
    case difficult
    when LEVELS[:easy] then DIFFICULTS[:easy]
    when LEVELS[:medium] then DIFFICULTS[:medium]
    when LEVELS[:hell] then DIFFICULTS[:hell]
    end
  end

  def go_game
    Representer.game_info_text(@game.attempts, @game.hints)
    guess = user_input until Guess.new(guess).validate
    show_hint if guess == Guess::HINT
    user_numbers = guess.chars.map(&:to_i)
    check_result(@game.start(user_numbers))
  end

  def check_result(result)
    lose if result == Game::LOSE
    win if result == Game::WIN
    Representer.show_result_msg(result)
    go_game
  end

  def show_hint
    @game.hints.zero? ? Representer.zero_hints_msg : Representer.showed_hint_msg(@game.hint)
    go_game
  end

  def lose
    Representer.lose_msg
    what_next
  end

  def win
    Representer.win_msg
    save_result if user_input == YES
    what_next
  end

  def save_result
    save_to_db(StatisticsResult.new(@user, @game.attempts, @game.hints))
  end

  def rules
    Representer.show_rules
    what_next
  end

  def statistics
    db = sort_db
    db.empty? ? Representer.empty_db_msg : Representer.show_db(db)
    what_next
  end

  def user_input
    input = gets.chomp.downcase
    input == EXIT ? Representer.goodbye : input
  end
end
