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
      case make_valid_input_for_class(Navigator).input
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

  def sort_db
    load_db.sort_by { |user| [user.all_attempts, -user.left_attempts, -user.left_hints] }
  end

  def registration
    Representer.what_name_msg
    @user = make_valid_input_for_class(User)
    @difficult = choose_difficulty
    @game = Game.new(@difficult.level[:attempts], @difficult.level[:hints])
    make_guess
  end

  def choose_difficulty
    Representer.select_difficult_msg
    loop do
      finded_level = Difficult.find(user_input)
      break finded_level if finded_level

      Representer.error_msg(I18n.t('invalid.include_error'))
    end
  end

  def make_guess
    loop do
      Representer.make_guess_msg
      guess = make_valid_input_for_class(Guess)
      guess.hint? ? show_hint : check_round_result(guess.as_array_of_numbers)
    end
  end

  def check_round_result(guess)
    return win if @game.win?(guess)

    round_result = @game.start_round(guess)
    return lose if @game.lose?

    Representer.round_info_text(round_result, @game.attempts, @game.hints)
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

  def make_valid_input_for_class(klass)
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
