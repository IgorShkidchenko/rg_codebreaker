# frozen_string_literal: true

module ValidatorsTexts
  WRONG_NAME_MSG = -> { puts 'Name must be from 3 to 20 characters'.red }
  WRONG_LEVEL_MSG = ->(level) { puts "I dont have '#{level}' level, try one more time".red }
  WRONG_COMMAND_MSG = ->(choice) { puts "You have passed unexpected command '#{choice}', try one more time".red }
  WRONG_GUESS_MSG = -> { puts "You need to enter 'hint' or four numbers between 1 and 6.".red }
  SELECT_DIFFICULT_MSG = -> { puts 'Select difficulty: '.yellow + 'easy, '.green + 'medium, '.pink + 'hell'.red }
  GOODBYE_MSG = -> { puts 'Goodbye'.pink }
end
