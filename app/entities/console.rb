# frozen_string_literal: true

class Console
  attr_reader :user, :difficult, :game
  include Uploader
  include Validator

  EXIT = 'exit'
  YES = 'yes'
  COMMANDS = { rules: 'rules', start: 'start', stats: 'stats' }.freeze

  def initialize
    @user = nil
    @difficult = nil
    @game = nil
    Representer.greeting_msg
  end

  def what_next
    Representer.what_next_text
    choice = user_input
    loop do
      break if validate_choice(choice)

      choice = user_input
    end
    case choice
    when COMMANDS[:rules] then rules
    when COMMANDS[:stats] then statistics
    when COMMANDS[:start] then registration
    end
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

  def registration
    choose_name
    choose_difficult
    @game = Game.new(@difficult.level[:attempts], @difficult.level[:hints])
    go_game
  end

  def choose_name
    Representer.what_name_msg
    loop do
      @user = User.new(user_input)
      break if @user.validate_name
    end
  end

  def choose_difficult
    Representer.select_difficult_msg
    loop do
      @difficult = Difficult.new(user_input)
      break if @difficult.validate_level
    end

    @difficult.select_difficult
  end

  def go_game
    Representer.game_info_text(@game.attempts, @game.hints)
    guess = Guess.new(user_input)
    loop do
      break if guess.validate_guess

      guess = Guess.new(user_input)
    end
    show_hint if guess.input == Guess::HINT
    user_numbers = guess.input.chars.map(&:to_i)
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
    save_to_db(StatisticsResult.new(name: @user.name, difficult: @difficult.level, game: @game))
  end

  def user_input
    input = gets.chomp.downcase
    input == EXIT ? Representer.goodbye : input
  end

  def validate_choice(choice)
    check_include?(choice, COMMANDS.values) ? true : Representer.wrong_choice_msg
  end
end
