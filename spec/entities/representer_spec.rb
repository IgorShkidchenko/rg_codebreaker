# frozen_string_literal: true

RSpec.describe Representer do
  let(:one) { 1 }
  let(:console) { Console.new }

  describe 'console_msg' do
    it { expect { Representer.greeting_msg }.to output(/Hello, lets play the 'Codebreaker' game/).to_stdout }
    it { expect { Representer.what_next_text }.to output(/Choose the command/).to_stdout }
    it { expect { Representer.what_name_msg }.to output(/What is your name/).to_stdout }
    it { expect { Representer.select_difficult_msg }.to output(/Select difficulty: easy, medium, hell/).to_stdout }
    it { expect { Representer.showed_hint_msg(one) }.to output(/Code contains this number:/).to_stdout }
    it { expect { Representer.zero_hints_msg }.to output(/You don't have any hints/).to_stdout }
    it { expect { Representer.show_result_msg(one) }.to output(/Your result is/).to_stdout }
    it { expect { Representer.game_info_text(one, one) }.to output(/Or enter 'hint' to open one digit /).to_stdout }
    it { expect { Representer.win_msg }.to output(/You win/).to_stdout }
    it { expect { Representer.lose_msg }.to output(/Game over/).to_stdout }
    it { expect { Representer.empty_db_msg }.to output(/You are the first one/).to_stdout }
    it { expect { Representer.show_db(console.load_db) }.to output(/Name:/).to_stdout }
    it { expect { Representer.show_rules }.to output(/Codebreaker is a logic game in which/).to_stdout }
  end

  describe 'validator_msg' do
    it { expect { Representer.wrong_name_msg }.to output(/Name must be from 3 to 20 characters/).to_stdout }
    it { expect { Representer.wrong_guess_msg }.to output(/You need to enter 'hint' or four /).to_stdout }
    it { expect { Representer.wrong_level_msg }.to output(/I dont have such level/).to_stdout }
    it { expect { Representer.wrong_choice_msg }.to output(/You have passed unexpected command/).to_stdout }
  end
end
