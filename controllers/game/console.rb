# frozen_string_literal: true

class Console
  attr_reader :hints, :attempts, :level, :name
  include Uploader
  include Validator
  include Game
  include Difficult
  include ConsoleTexts

  def initialize
    GREETING_MSG.call
    what_next
  end

  private

  def what_next
    what_next_text
    case validated_choice
    when 'rules' then show_rules
    when 'stats' then show_statistics
    when 'start' then go_game
    when 'exit' then GOODBYE_MSG.call
    end
  end

  def registration
    reg_first_step
    reg_second_step
    p @breaker_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @copy_for_hints = @breaker_numbers.clone
    LOGIN_AS_MSG.call(@name, @level)
  end

  def reg_first_step
    WHAT_NAME_MSG.call
    @name = validated_name
  end

  def reg_second_step
    selected = select_difficult
    @hints = selected[:hints]
    @attempts = selected[:attempts]
    @level = selected[:level]
  end

  def go_game
    registration if @name.nil?
    lose if @attempts.zero?
    game_info_text(@attempts, @hints)
    guess = validated_guess
    show_hint if guess == 'hint'
    result = start(guess, @breaker_numbers)
    SHOW_RESULT_MSG.call(result)
    return win if result == ['+', '+', '+', '+']

    go_game
  end

  def show_hint
    if @hints.zero?
      ZERO_HINTS_MSG.call
      go_game
    end
    showed = hint(@copy_for_hints)
    SHOWED_HINT_MSG.call(showed)
    @copy_for_hints.delete_at(@copy_for_hints.index(showed))
    @hints -= 1
    go_game
  end

  def win
    WIN_MSG.call
    want_to_save = gets.chomp.downcase
    save_to_db if want_to_save == 'yes'
    @name = nil
    what_next
  end

  def lose
    LOSE_MSG.call
    @name = nil
    what_next
  end

  def show_statistics
    load_db.empty? ? EMPTY_DB_MSG.call : show_db(load_db)
    what_next
  end
end
