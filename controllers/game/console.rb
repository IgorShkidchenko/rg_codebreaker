# frozen_string_literal: true

class Console
  attr_reader :hints, :attempts, :level, :name
  include Uploader
  include Validator
  include Game
  include Difficult

  def initialize
    puts "Hello, lets play the 'Codebreaker' game".green
    what_next
  end

  private

  def what_next
    what_next_text
    case validated_choice
    when 'rules' then show_rules
    when 'stats' then show_statistics
    when 'start' then go_game
    when 'exit' then puts 'Goodbye'.pink
    end
  end

  def registration
    puts "What is your name?\nEnter ".green + 'random'.pink + ' to auto-create your name'.green
    @name = validated_name
    selected = select_difficult
    @hints = selected[:hints]
    @attempts = selected[:attempts]
    @level = selected[:level]
    @breaker_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @copy_for_hints = @breaker_numbers.clone
    puts "You log in as #{@name}\nChoosen difficult is #{@level}".green
  end

  def what_next_text
    puts "Choose the command".yellow
    puts '-Enter '.green + 'rules'.pink + ' if you want to see rules of the game'.green
    puts '-Enter '.green + 'start'.pink + ' if you want to start the game'.green
    puts '-Enter '.green + 'stats'.pink + ' if you want to see the statistics of players results'.green
    puts '-Enter '.green + 'exit'.pink + ' if you want to quite the game'.green
  end

  def go_game
    registration if @name.nil?
    lose if @attempts.zero?
    puts "You have #{@attempts} attempts and #{@hints} hints".pink
    puts "Make your guess\n".green + 'You need to enter four numbers between 1 and 6 '.yellow
    @hints.zero? ? (puts "You don't have any hints".yellow) : (puts "Or enter 'hint' to open one digit from code".green)
    guess = validated_guess
    show_hint if guess == 'hint'
    result = start(guess, @breaker_numbers)
    puts 'Your result is '.green + result.to_s.pink
    return win if result == ['+', '+', '+', '+']
    go_game
  end
  
  def show_hint
    if @hints.zero?
      puts "You don't have any hints".red 
      go_game
    end
    showed = hint(@copy_for_hints)
    puts 'Code contains this number: '.green + showed.to_s.pink
    @copy_for_hints.delete_at(@copy_for_hints.index showed)
    @hints -= 1
    go_game
  end

  def win
    puts 'You win'.green
    puts '-Enter '.green + 'yes'.pink + ' if you want to save your progress'.green
    want_to_save = gets.chomp.downcase
    save_to_db if want_to_save == 'yes'
    @name = nil
    what_next
  end

  def lose
    puts 'Game over, you lose if you want you can start a new game'.red
    @name = nil
    what_next
  end

  def show_statistics
    if load_db.empty?
      puts 'You are the first one'.green
      what_next
    end

    puts "Hall of fame:\n".green
    load_db.each do |player|
      puts "#{player.name} on #{player.level} level"
    end
    what_next
  end

  def show_rules
    rules_path = './helpers/rules.docx'
    doc = Docx::Document.open(rules_path)
    doc.paragraphs.each do |paragraph|
      puts paragraph
    end
    what_next
  end
end
