# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  let(:one) { 1 }
  let(:zero) { 0 }
  let(:loaded_db) { subject.load_db }

  describe '#check_text_module' do
    it 'greeting_msg_when_start' do
      expect { subject }.to output(/Hello, lets play the 'Codebreaker' game/).to_stdout
    end

    it 'what_next_text' do
      expect { subject.what_next_text }.to output(/Choose the command/).to_stdout
    end

    it 'game_info_text_with_some_hints' do
      expect { subject.game_info_text(one, one) }.to output(/Or enter 'hint' to open one digit from code/).to_stdout
    end

    it 'game_info_text_with_zero_hints' do
      expect { subject.game_info_text(one, zero) }.to output(/You don't have any hints/).to_stdout
    end

    it 'show_db' do
      expect { subject.show_db(loaded_db) }.to output(/Hall of fame:/).to_stdout
    end

    it 'show_rules' do
      allow(subject).to receive(:what_next)
      expect { subject.show_rules }.to output(/Codebreaker is a logic game in which/).to_stdout
    end
  end
end
