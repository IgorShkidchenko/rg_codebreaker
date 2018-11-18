# frozen_string_literal: true

module Game
  def start(guess, breaker_numbers)
    @attempts -= 1
    user_numbers = guess.chars.map(&:to_i)
    zip_numbers = breaker_numbers.zip(user_numbers)
    result = check_guess(zip_numbers, breaker_numbers)
    @wins += 1 if result == ['+', '+', '+', '+']
    result
  end

  def check_guess(zip_numbers, breaker_numbers)
    zip_numbers.map do |breaker_num, user_num|
      case
      when breaker_num == user_num then '+'
      when breaker_num != user_num && breaker_numbers.include?(user_num) then '-'
      else ''
      end
    end
  end

  def show_hint(numbers)
    @hints -= 1
    result = %w[x x x x]
    random_number = numbers[rand(0..3)]
    index_random_number = numbers.index(random_number)
    result[index_random_number] = random_number
    result
  end
end
