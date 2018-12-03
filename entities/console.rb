# frozen_string_literal: true

class Console
  attr_reader :user, :game
  include Uploader
  include Validator

  def initialize
    @user = nil
    @game = nil
    Representer.greeting_msg
  end

  def what_next
    Representer.what_next_text
    case validated_choice
    when 'rules' then rules
    when 'stats' then statistics
    when 'start' then registration
    end
  end

  def registration
    Representer.what_name_msg
    @user = User.new(validated_name, select_difficult)
    @game = Game.new(@user.difficult)
    go_game
  end

  def select_difficult
    Representer.select_difficult_msg
    case validated_difficult
    when 'easy' then { hints: 2, attempts: 15, level: 'easy' }
    when 'medium' then { hints: 1, attempts: 10, level: 'medium' }
    when 'hell' then { hints: 1, attempts: 5, level: 'hell' }
    end
  end

  def go_game
    Representer.game_info_text(@game.attempts, @game.hints)
    guess = validated_guess
    guess == 'hint' ? show_hint : user_numbers = guess.chars.map(&:to_i)
    check_result(@game.start(user_numbers))
  end

  def check_result(result)
    lose if result == :lose
    win if result == :win
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
    save_result if gets.chomp.casecmp('yes').zero?
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
end
