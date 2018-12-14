# frozen_string_literal: true

RSpec.describe Representer do
  let(:first_name_when_sort_db) { 'Player1' }
  let(:difficulty_keys) { Difficulty::DIFFICULTIES.keys.join(', ') }
  let(:arg) { 1 }
  let(:error) { 'Invalid error' }
  let(:first_result) do
    instance_double('StatisticsResult', name: first_name_when_sort_db, all_attempts: 15,
                                        all_hints: 2, level: 'easy', left_attempts: 10, left_hints: 1)
  end

  describe '.console_msg' do
    it { expect { described_class.greeting_msg }.to output(/Hello, lets play the 'Codebreaker' game/).to_stdout }
    it { expect { described_class.what_next_text }.to output(/Choose the command/).to_stdout }
    it { expect { described_class.what_name_msg }.to output(/What is your name/).to_stdout }
    it { expect { described_class.select_difficulty_msg }.to output(/Select difficulty: #{difficulty_keys}/).to_stdout }
    it { expect { described_class.make_guess_msg }.to output(/Make your guess/).to_stdout }
    it { expect { described_class.showed_hint_msg(arg) }.to output(/Code contains this number:/).to_stdout }
    it { expect { described_class.zero_hints_msg }.to output(/You don't have any hints/).to_stdout }
    it { expect { described_class.round_info_text(arg, arg, arg) }.to output(/Your result is 1/).to_stdout }
    it { expect { described_class.win_msg }.to output(/You win/).to_stdout }
    it { expect { described_class.lose_msg }.to output(/Game over/).to_stdout }
    it { expect { described_class.empty_db_msg }.to output(/You are the first one/).to_stdout }
    it { expect { described_class.show_db([first_result]) }.to output(/Name: #{first_result.name} diff/).to_stdout }
    it { expect { described_class.show_rules }.to output(/Codebreaker is a logic game in which/).to_stdout }
  end

  describe '.error_msg' do
    it { expect { described_class.error_msg(error) }.to output(/Unexpected input, it was '#{error}'/).to_stdout }
  end

  describe '.goodbye_msg' do
    it { expect { described_class.goodbye }.to output(/Goodbye/).to_stdout }
  end

  describe '#sort_db' do
    it do
      results = Array.new(5) do |index|
        instance_double('StatisticsResult', name: "Player#{index + 2}", all_attempts: 15,
                                            all_hints: 2, level: 'easy', left_attempts: index, left_hints: 10 - index)
      end

      results << first_result
      expect(described_class.send(:sort_db, results).first.name).to eq(first_name_when_sort_db)
      expect(described_class.send(:sort_db, results).last.name).to eq(results.first.name)
    end
  end
end
