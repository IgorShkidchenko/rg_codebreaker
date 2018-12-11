# frozen_string_literal: true

class Console < ValidatableEntity
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
      case validate_input_for(Navigator).input
      when COMMANDS[:start] then return registration
      when COMMANDS[:rules] then Representer.show_rules
      when COMMANDS[:stats] then statistics
      end
    end
  end

  private

  def statistics
    db = sort_db
    db.empty? ? Representer.empty_db_msg : Representer.show_db(db)
  end

  def registration
    Representer.what_name_msg
    @user = validate_input_for(User)
    choose_difficult
    @game = Game.new(@difficult.level[:attempts], @difficult.level[:hints])
    make_guess
  end

  def choose_difficult
    Representer.select_difficult_msg
    loop do
      @difficult = Difficult.find(user_input)
      break if @difficult

      Representer.error_msg(I18n.t('exceptions.include_error'))
    end
  end

  def make_guess
    loop do
      Representer.make_guess_msg
      @guess = validate_input_for(Guess)
      @guess.hint? ? show_hint : check_game_result
    end
  end

  def check_game_result
    guess_array = @guess.as_array_of_numbers
    return win if @game.win?(guess_array)

    game_result = @game.start(guess_array)
    return lose if @game.lose?

    Representer.game_info_text(game_result, @game.attempts, @game.hints)
  end

  def show_hint
    @game.hints.positive? ? Representer.showed_hint_msg(@game.hint) : Representer.zero_hints_msg
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

  def validate_input_for(klass)
    loop do
      input = klass.new(user_input)
      input.validate
      break input if input.valid?

      Representer.error_msg(input.errors.join(', '))
    end
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
