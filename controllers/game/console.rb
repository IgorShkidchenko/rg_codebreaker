# frozen_string_literal: true

class Console
  include Uploader
  include Validator
  include ConsoleTexts

  def initialize
    puts GREETING_MSG
  end

  def what_next
    what_next_text
    case validated_choice
    when 'rules' then show_rules
    when 'stats' then show_statistics
    when 'start' then registration
    when 'exit' then puts GOODBYE_MSG
    end
  end

  def registration
    puts WHAT_NAME_MSG
    name = validated_name
    selected_difficult = select_difficult
    @game = Game.new(name, selected_difficult)
    login_as_msg(@game.name, @game.level)
    go_game
  end

  def go_game
    game_info_text(@game.attempts, @game.hints)
    guess = validated_guess
    show_hint if guess == 'hint'
    result = @game.start(guess)
    return lose if result == :lose

    show_result_msg(result)
    return win if result == ['+', '+', '+', '+']

    go_game
  end

  def show_hint
    if @game.hints.zero?
      puts ZERO_HINTS_MSG
      return go_game
    end
    showed = @game.hint
    showed_hint_msg(showed)
    go_game
  end

  def win
    puts WIN_MSG
    want_to_save = gets.chomp.downcase
    save_result if want_to_save == 'yes'
    what_next
  end

  def save_result
    result = StatisticsResult.new(name: @game.name, attempts: @game.attempts, hints: @game.hints, level: @game.level)
    save_to_db(result)
  end

  def lose
    puts LOSE_MSG
    what_next
  end

  def show_statistics
    load_db.empty? ? (puts EMPTY_DB_MSG) : show_db(load_db)
    what_next
  end

  def select_difficult
    case validated_difficult
    when 'easy' then { hints: 2, attempts: 15, level: 'easy' }
    when 'medium' then { hints: 1, attempts: 10, level: 'medium' }
    when 'hell' then { hints: 1, attempts: 5, level: 'hell' }
    end
  end
end
