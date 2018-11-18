# frozen_string_literal: true

class Console
  attr_reader :wins, :hint, :attempts, :level, :name
  include Uploader
  include Validator
  include Game

  def initialize
    @wins = 0
    @hints = 4
    @attempts = 10
    @level = 'easy'
    @name = greeting
    what_next
  end

  def what_next
    what_next_text
    case validate_choice
    when 'rules' then show_rules
    when 'table' then show_statistics
    when 'play' then go_game
    when 'weather' then show_weather
    when 'save' then go_save
    when 'exit' then puts 'Bye'.green
    end
  end

  private

  def greeting
    puts "Hello, lets play 'Cows & Bulls'\nWhat is your name?\nEnter 'random' to auto-create name for you".green
    player_name = validate_name
    puts "You log in as #{player_name}".green
    player_name
  end

  def what_next_text
    puts "So #{@name} what next?".yellow
    puts '-Enter '.green + 'rules'.pink + ' if you want to see rules of the game'.green
    puts '-Enter '.green + 'play'.pink + ' if you want to start the game'.green unless @attempts.zero?
    puts '-Enter '.green + 'table'.pink + ' if you want to see the statistics of players results'.green
    puts '-Enter '.green + 'weather'.pink + ' if you want to see the the weather'.green
    puts '-Enter '.green + 'save'.pink + ' if you want to save your progress'.green
    puts '-Enter '.green + 'exit'.pink + ' if you want to quite the game'.green
  end

  def go_game
    select_difficult if @attempts == 10
    return what_next if @attempts.zero?
    puts "You have #{@attempts} attempts and #{@hints} hints".pink
    breaker_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    puts 'Make your guess'.green
    guess = validate_guess
    if guess == 'hint'
      @hints.zero? ? (puts "You don't have any hints".red) : (p show_hint(breaker_numbers))
      guess = validate_guess
    end
    show_result(start(guess, breaker_numbers))
  end

  def show_result(result)
    puts "Your result is - #{result}\nWins - #{@wins}"
    puts 'Game over'.red + ' you can save your progress'.green if @attempts.zero?
    what_next
  end

  def select_difficult
    puts 'Select difficult: '.green + 'easy, '.pink + 'medium, '.pink + 'hard'.pink
    case validate_difficult
    when 'medium'
      @hint = 2
      @attempts = 8
      @level = 'medium'
    when 'hard'
      @hint = 1
      @attempts = 6
      @level = 'hard'
    end
  end

  def go_save
    save_to_db
    what_next
  end

  def show_statistics
    if load_db.empty?
      puts 'You are the first on'.green
      what_next
    end

    puts "Hall of fame:\n".green
    load_db.each do |player|
      puts "#{player.name} wins - #{player.wins} on #{player.level} level"
    end
    what_next
  end

  def show_weather
    puts `curl https://wttr.in?0`
    what_next
  end

  def show_rules
    rule_path = '/html/body/div[3]/div[3]/div[4]/div/p'
    wiki_path = 'https://en.wikipedia.org/wiki/Bulls_and_Cows'
    doc = Nokogiri::HTML(open(wiki_path))
    doc.xpath(rule_path + '[3]', rule_path + '[4]', rule_path + '[5]').each do |link|
      puts link.content
    end
    what_next
  end
end
