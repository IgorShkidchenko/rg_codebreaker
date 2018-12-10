# frozen_string_literal: true

class Console < ValidatableEntity
  attr_reader :user, :difficult, :game
  include Uploader

  ACCEPT_SAVING_RESULT = 'yes'
  COMMANDS = { rules: 'rules',
               start: 'start',
               stats: 'stats',
               exit: 'exit' }.freeze

  def greeting
    Representer.greeting_msg
  end

  def main_menu
    loop do
      Representer.what_next_text
      case choose_step
      when COMMANDS[:start] then return registration
      when COMMANDS[:rules] then Representer.show_rules
      when COMMANDS[:stats] then statistics
      end
    end
  end

  private

  def choose_step
    begin
      choice = user_input
      check_include?(choice, COMMANDS.values)
    rescue IncludeError => error
      Representer.error_msg(error.message)
      retry
    end
    choice
  end

  def statistics
    db = sort_db
    db.empty? ? Representer.empty_db_msg : Representer.show_db(db)
  end

  def registration
    Representer.what_name_msg
    choose_name
    Representer.select_difficult_msg
    choose_difficult
    @game = Game.new(@difficult.level[:attempts], @difficult.level[:hints])
    make_guess
  end

  def choose_name
    @user = User.new(user_input)
    @user.validate
  rescue CoverError => error
    Representer.error_msg(error.message)
    retry
  end

  def choose_difficult
    @difficult = Difficult.new(user_input)
    @difficult.validate
  rescue IncludeError => error
    Representer.error_msg(error.message)
    retry
  end

  def make_guess
    Representer.make_guess_msg
    begin
      guess = Guess.new(user_input)
      guess.validate
    rescue *Guess::EXCEPTIONS => error
      Representer.error_msg(error.message)
      retry
    end
    guess.input == Guess::HINT ? show_hint : check_result(@game.start(guess.make_array_of_numbers))
  end

  def check_result(result)
    return win if @game.win?(result)
    return lose if @game.lose?

    Representer.show_result_msg(result)
    Representer.game_info_text(@game.attempts, @game.hints)
    make_guess
  end

  def show_hint
    @game.hints.positive? ? Representer.showed_hint_msg(@game.hint) : Representer.zero_hints_msg
    make_guess
  end

  def lose
    Representer.lose_msg
    main_menu
  end

  def win
    Representer.win_msg
    save_result if user_input == ACCEPT_SAVING_RESULT
    main_menu
  end

  def save_result
    save_to_db(StatisticsResult.new(name: @user.name, difficult: @difficult.level, game: @game))
  end

  def user_input
    input = gets.chomp.downcase
    input == COMMANDS[:exit] ? exit_console : input
  end

  def exit_console
    Representer.goodbye
    exit
  end
end
