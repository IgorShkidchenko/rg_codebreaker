# frozen_string_literal: true

RSpec.describe Representer do
  let(:some_arg) { 1 }
  let(:error) { 'Invalid error' }
  let(:result) do
    double('StatisticsResult', name: 'John', all_attempts: 15,
                               all_hints: 2, level: 'easy', left_attempts: 10, left_hints: 1)
  end

  describe '.console_msg' do
    it { expect { Representer.greeting_msg }.to output(/Hello, lets play the 'Codebreaker' game/).to_stdout }
    it { expect { Representer.what_next_text }.to output(/Choose the command/).to_stdout }
    it { expect { Representer.what_name_msg }.to output(/What is your name/).to_stdout }
    it { expect { Representer.select_difficult_msg }.to output(/Select difficulty: easy, medium, hell/).to_stdout }
    it { expect { Representer.make_guess_msg }.to output(/Make your guess/).to_stdout }
    it { expect { Representer.showed_hint_msg(some_arg) }.to output(/Code contains this number:/).to_stdout }
    it { expect { Representer.zero_hints_msg }.to output(/You don't have any hints/).to_stdout }
    it { expect { Representer.round_info_text(some_arg, some_arg, some_arg) }.to output(/Your result is 1/).to_stdout }
    it { expect { Representer.win_msg }.to output(/You win/).to_stdout }
    it { expect { Representer.lose_msg }.to output(/Game over/).to_stdout }
    it { expect { Representer.empty_db_msg }.to output(/You are the first one/).to_stdout }
    it { expect { Representer.show_db([result]) }.to output(/Name: John Difficult: easy/).to_stdout }
    it { expect { Representer.show_rules }.to output(/Codebreaker is a logic game in which/).to_stdout }
  end

  describe '.error_msg' do
    it { expect { Representer.error_msg(error) }.to output(/Unexpected input, it was '#{error}'/).to_stdout }
  end

  describe '.goodbye_msg' do
    it { expect { Representer.goodbye }.to output(/Goodbye/).to_stdout }
  end
end
