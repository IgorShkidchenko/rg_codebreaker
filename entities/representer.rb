# frozen_string_literal: true

class Representer
  class << self
    RULES = '-Enter '.green + 'rules'.pink + ' if you want to see rules of the game'.green
    STATS = '-Enter '.green + 'stats'.pink + ' if you want to see the statistics of users results'.green
    START = '-Enter '.green + 'start'.pink + ' if you want to start the game'.green
    EXIT = -'-Enter '.green + 'exit'.pink + ' if you want to quite the game'.green

    def greeting_msg
      puts "Hello, lets play the 'Codebreaker' game".green
    end

    def goodbye
      puts 'Goodbye'.pink
      exit
    end

    def what_next_text
      puts 'Choose the command'.yellow
      puts RULES
      puts STATS
      puts START
      puts EXIT
    end

    def what_name_msg
      puts "What is your name?\nEnter ".green + 'random'.pink + ' to auto-create your name'.green
    end

    def showed_hint_msg(showed)
      puts 'Code contains this number: '.green + showed.to_s.pink
    end

    def zero_hints_msg
      puts "You don't have any hints".red
    end

    def show_result_msg(result)
      puts 'Your result is '.green + result.to_s.pink
    end

    def game_info_text(attempts, hints)
      puts "You have #{attempts} attempts and #{hints} hints".green
      puts "Make your guess\n".green + 'You need to enter four numbers between 1 and 6 '.yellow
      hints.zero? ? (puts "You don't have any hints".pink) : (puts "Or enter 'hint' to open one digit from code".pink)
    end

    def win_msg
      puts "You win\n-Enter ".green + 'yes'.pink + ' if you want to save your progress'.green
    end

    def lose_msg
      puts 'Game over, you lose if you want you can start a new game'.red
    end

    def empty_db_msg
      puts 'You are the first one'.green
    end

    def show_db(db)
      puts 'Hall of fame:'.yellow
      position = 0
      db.each do |user|
        position += 1
        puts "#{position}) Name: #{user.name} Difficult: #{user.level}".pink
        puts "Attempts: #{user.all_attempts}/#{user.left_attempts}
              Hints: #{user.all_hints}/#{user.left_hints}".green
      end
    end

    def show_rules(doc)
      doc.paragraphs.each do |paragraph|
        puts paragraph
      end
    end

    def select_difficult_msg
      puts 'Select difficulty: '.yellow + 'easy, '.green + 'medium, '.pink + 'hell'.red
    end

    def wrong_name_msg
      puts 'Name must be from 3 to 20 characters'.red
    end

    def wrong_guess_msg
      puts "You need to enter 'hint' or four numbers between 1 and 6.".red
    end

    def wrong_level_msg
      puts 'I dont have such level, try one more time'.red
    end

    def wrong_choice_msg
      puts 'You have passed unexpected command, try one more time'.red
    end
  end
end
