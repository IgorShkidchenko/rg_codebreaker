# frozen_string_literal: true

module ValidatorsTexts
  WRONG_NAME_MSG = 'Name must be from 3 to 20 characters'.red
  WRONG_GUESS_MSG = "You need to enter 'hint' or four numbers between 1 and 6.".red
  SELECT_DIFFICULT_MSG = 'Select difficulty: '.yellow + 'easy, '.green + 'medium, '.pink + 'hell'.red
  GOODBYE_MSG = 'Goodbye'.pink

  def wrong_level_msg(level)
    puts "I dont have '#{level}' level, try one more time".red
  end

  def wrong_command_msg(choice)
    puts "You have passed unexpected command '#{choice}', try one more time".red
  end
end
