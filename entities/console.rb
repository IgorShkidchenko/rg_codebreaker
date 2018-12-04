# frozen_string_literal: true

class Console
  attr_reader :user, :game
  include Uploader
  include Validator

  COMMANDS = { rules: 'rules', start: 'start', stats: 'stats' }.freeze
  HINT = 'hint'
  EXIT = 'exit'
  YES = 'yes'

  def initialize
    @user = nil
    @game = nil
    Representer.greeting_msg
  end

  def what_next
    Representer.what_next_text
    choice = user_input until valid_choice?(choice)
    case choice
    when COMMANDS[:rules] then rules
    when COMMANDS[:stats] then statistics
    when COMMANDS[:start] then registration
    end
  end

  def registration
    @user = User.new
    @game = Game.new(@user.difficult[:attempts], @user.difficult[:hints])
    go_game
  end

  def go_game
    Representer.game_info_text(@game.attempts, @game.hints)
    guess = user_input until valid_guess?(guess)
    show_hint if guess == HINT
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
