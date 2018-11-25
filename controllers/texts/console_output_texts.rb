# frozen_string_literal: true

module ConsoleTexts
  RULES = '-Enter '.green + 'rules'.pink + ' if you want to see rules of the game'.green
  STATS = '-Enter '.green + 'stats'.pink + ' if you want to see the statistics of players results'.green
  START = '-Enter '.green + 'start'.pink + ' if you want to start the game'.green
  EXIT = -'-Enter '.green + 'exit'.pink + ' if you want to quite the game'.green

  GOODBYE_MSG = -> { puts 'Goodbye'.pink }
  GREETING_MSG = -> { puts "Hello, lets play the 'Codebreaker' game".green }
  LOGIN_AS_MSG = ->(name, level) { puts "You log in as #{name}\nChoosen difficult is #{level}".green }
  WHAT_NAME_MSG = -> { puts "What is your name?\nEnter ".green + 'random'.pink + ' to auto-create your name'.green }
  SHOW_RESULT_MSG = ->(result) { puts 'Your result is '.green + result.to_s.pink }
  ZERO_HINTS_MSG = -> { puts "You don't have any hints".red }
  SHOWED_HINT_MSG = ->(showed) { puts 'Code contains this number: '.green + showed.to_s.pink }
  WIN_MSG = -> { puts "You win\n-Enter ".green + 'yes'.pink + ' if you want to save your progress'.green }
  LOSE_MSG = -> { puts 'Game over, you lose if you want you can start a new game'.red }
  EMPTY_DB_MSG = -> { puts 'You are the first one'.green }

  def what_next_text
    puts 'Choose the command'.yellow
    puts RULES
    puts STATS
    puts START
    puts EXIT
  end

  def game_info_text(attempts, hints)
    puts "You have #{attempts} attempts and #{hints} hints".pink
    puts "Make your guess\n".green + 'You need to enter four numbers between 1 and 6 '.yellow
    hints.zero? ? (puts "You don't have any hints".yellow) : (puts "Or enter 'hint' to open one digit from code".green)
  end

  def show_db(db)
    puts "Hall of fame:\n".green
    db.each do |player|
      puts "#{player.name} on #{player.level} level"
    end
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
