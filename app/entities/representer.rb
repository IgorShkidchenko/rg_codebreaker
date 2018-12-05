# frozen_string_literal: true

class Representer
  EXIT = -> { exit }

  class << self
    def greeting_msg
      puts I18n.t('console.greeting')
    end

    def goodbye
      puts I18n.t(:goodbye)
      EXIT.call
    end

    def what_next_text
      puts I18n.t('console.choose_the_command')
    end

    def what_name_msg
      puts I18n.t('console.what_name')
    end

    def select_difficult_msg
      puts I18n.t('console.select_difficult')
    end

    def showed_hint_msg(showed)
      puts I18n.t('console.showed_hint', showed: showed)
    end

    def zero_hints_msg
      puts I18n.t('console.zero_hints')
    end

    def show_result_msg(result)
      puts I18n.t('console.result', result: result)
    end

    def game_info_text(attempts, hints)
      puts I18n.t('console.left_attempts_and_hints', attempts: attempts, hints: hints)
      puts I18n.t('console.make_guess')
      puts I18n.t('console.enter_hint') if hints.positive?
    end

    def win_msg
      puts I18n.t('console.win')
    end

    def lose_msg
      puts I18n.t('console.lose')
    end

    def empty_db_msg
      puts I18n.t('console.empty_db')
    end

    def show_db(db)
      position = 0
      db.each do |user|
        position += 1
        puts I18n.t('console.stats_user_info', position: position, name: user.name, level: user.level)
        puts I18n.t('console.stats_lefts', attempts: user.left_attempts, all_attempts: user.all_attempts,
                                           hints: user.left_hints, all_hints: user.all_hints)
      end
    end

    def show_rules
      puts I18n.t('console.rules')
    end

    def wrong_name_msg
      puts I18n.t('validator.wrong_name')
    end

    def wrong_guess_msg
      puts I18n.t('validator.wrong_guess')
    end

    def wrong_level_msg
      puts I18n.t('validator.wrong_level')
    end

    def wrong_choice_msg
      puts I18n.t('validator.wrong_choice')
    end
  end
end
