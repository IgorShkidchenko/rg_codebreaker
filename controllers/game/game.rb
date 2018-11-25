# frozen_string_literal: true

module Game
  def start(guess, breaker_numbers)
    @attempts -= 1
    user_numbers = guess.chars.map(&:to_i)
    check_guess(breaker_numbers.zip(user_numbers), breaker_numbers, user_numbers).compact.sort!
  end

  def check_guess(zip_numbers, breaker_numbers, user_numbers)
    checked = []
    zip_numbers.map do |breaker_num, user_num|
      if breaker_num == user_num
        checked << user_num if user_numbers.count(breaker_num) > 1
        '+'
      elsif breaker_num != user_num && breaker_numbers.include?(user_num) && !checked.include?(user_num)
        checked << user_num
        '-'
      end
    end
  end

  def hint(code_numbers)
    code_numbers[rand(0...code_numbers.size)]
  end
end
