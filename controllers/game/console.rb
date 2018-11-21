# frozen_string_literal: true

class Console
  attr_reader :wins, :hint, :attempts, :level, :name
  include Uploader
  include Validator
  include Game
  include Difficult

  def initialize
    @wins = 0
    puts "Hello, lets play the 'Codebreaker' game".green
    what_next
  end

  def what_next
    what_next_text
    case validated_choice
    when 'rules' then show_rules
    when 'stats' then show_statistics
    when 'start' then go_game
    when 'save' then go_save
    when 'exit' then puts 'Goodbye'.pink
    end
  end

  private

  def greeting
    puts "What is your name?\nEnter 'random' to auto-create your name".green
    player_name = validated_name
    puts "You log in as #{player_name}".green
    player_name
  end

  def what_next_text
    puts "Choose the command".yellow
    puts '-Enter '.green + 'rules'.pink + ' if you want to see rules of the game'.green
   # puts '-Enter '.green + 'start'.pink + ' if you want to start the game'.green unless @attempts.zero?
    puts '-Enter '.green + 'stats'.pink + ' if you want to see the statistics of players results'.green
    puts '-Enter '.green + 'save'.pink + ' if you want to save your progress'.green
    puts '-Enter '.green + 'exit'.pink + ' if you want to quite the game'.green
  end

  def go_game
    @name = greeting if @name.nil?
    select_difficult if @attempts == 10
    return what_next if @attempts.zero?
    puts "You have #{@attempts} attempts and #{@hints} hints".pink
    breaker_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    puts 'Make your guess'.green
    puts "You need to enter 'hint' or four numbers between 1 and 6.".yellow
    guess = validated_guess
    if guess == 'hint'
      @hints.zero? ? (puts "You don't have any hints".red) : (p show_hint(breaker_numbers))
      guess = validated_guess
    end
    show_result(start(guess, breaker_numbers))
  end
#start_new_game
  def show_result(result)
    puts "Your result is - #{result}\nWins - #{@wins}"
    puts 'Game over'.red + ' you can save your progress'.green if @attempts.zero?
    what_next
  end

  def go_save
    save_to_db
    what_next
  end

  def show_statistics
    if load_db.empty?
      puts 'You are the first one'.green
      what_next
    end

    puts "Hall of fame:\n".green
    load_db.each do |player|
      puts "#{player.name} wins - #{player.wins} on #{player.level} level"
    end
    what_next
  end

  def show_rules
    rules_path = './helpers/rules.docx'
    doc = Docx::Document.open(rules_path)
    doc.paragraphs.each do |paragraph|
      puts paragraph
    end
  end
end
