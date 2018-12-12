# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  let(:user_double) { double('User', name: 'John') }
  let(:difficult_double) { double('Difficult', input: 'easy', level: Difficult::DIFFICULTIES[:easy]) }
  let(:game_double) { double('Game', attempts: 15, hints: 2) }
  let(:game_double_with_zeros) { double('Game', attempts: 0, hints: 0) }

  let(:path_to_test_db) { './spec/fixtures/test_database.yaml' }
  let(:valid_path) { [Console::COMMANDS[:start], user_double.name, Difficult::DIFFICULTIES[:easy][:level]] }
  let(:valid_guess) { Guess::VALID_NUMBERS.sample(4).join }
  let(:first_name_when_sort_db) { 'Player1' }

  let(:empty_string) { '' }
  let(:long_name) { 'aaaaaaaaaaaaaaaaaaaaa' }
  let(:invalid_guess) { '9999' }
  let(:two_invalid_strings) { [empty_string, long_name] }

  describe '.new' do
    it { expect(subject.instance_variable_get(:@errors)).to eq([]) }
  end

  describe '#greating' do
    it do
      expect(Representer).to receive(:greeting_msg)
      subject.greeting
    end
  end

  describe 'navigate' do
    after { subject.main_menu }

    describe '#main_menu' do
      context 'registration_redirect' do
        it do
          allow(subject).to receive(:user_input).and_return(Console::COMMANDS[:start])
          expect(subject).to receive(:registration)
        end
      end

      before { allow(subject).to receive(:registration) }

      context '#show_rules_redirect_and_show' do
        it do
          allow(subject).to receive(:user_input).and_return(Console::COMMANDS[:rules], Console::COMMANDS[:start])
          expect(Representer).to receive(:show_rules)
        end
      end

      context 'statistics_redirect' do
        it do
          allow(subject).to receive(:user_input).and_return(Console::COMMANDS[:stats], Console::COMMANDS[:start])
          expect(subject).to receive(:statistics)
        end
      end

      context 'invalid' do
        it do
          allow(subject).to receive(:user_input).and_return(*two_invalid_strings, Console::COMMANDS[:start])
          expect(Representer).to receive(:error_msg).twice
        end
      end
    end

    context 'redirect_to_make_guess' do
      it do
        allow(subject).to receive(:user_input).and_return(*valid_path)
        expect(subject).to receive(:make_guess)
      end
    end
  end

  describe 'check_loops' do
    before { expect(subject).to receive(:user_input).exactly(3).times }

    context '#make_valid_input_for_class(Guess)' do
      it do
        allow(subject).to receive(:user_input).and_return(empty_string, invalid_guess, valid_guess)
        subject.send(:make_valid_input_for_class, Guess)
      end
    end

    context '#make_valid_input_for_class(User)' do
      it do
        allow(subject).to receive(:user_input).and_return(*two_invalid_strings, user_double.name)
        subject.send(:make_valid_input_for_class, User)
      end
    end

    context '#choose_difficulty' do
      it do
        allow(subject).to receive(:user_input).and_return(*two_invalid_strings, Difficult::DIFFICULTIES[:easy][:level])
        subject.send(:choose_difficulty)
      end
    end
  end

  describe '#show_hint' do
    after do
      allow(subject.instance_variable_get(:@game)).to receive(:hint)
      subject.send(:show_hint)
    end

    context 'with_some_hints' do
      it do
        subject.instance_variable_set(:@game, game_double)
        expect(Representer).to receive(:showed_hint_msg)
      end
    end

    context 'with_zero_hints' do
      it do
        subject.instance_variable_set(:@game, game_double_with_zeros)
        expect(Representer).to receive(:zero_hints_msg)
      end
    end
  end

  describe '#check_round_result' do
    before do
      subject.instance_variable_set(:@game, game_double_with_zeros)
      allow(subject.instance_variable_get(:@game)).to receive(:win?)
    end

    after do
      allow(subject.instance_variable_get(:@game)).to receive(:start_round)
      subject.send(:check_round_result, nil)
    end

    context 'redirect_to_lose_if_zero_attempts_left' do
      it do
        allow(subject.instance_variable_get(:@game)).to receive(:lose?) { true }
        expect(subject).to receive(:lose)
      end
    end

    before { allow(subject.instance_variable_get(:@game)).to receive(:lose?) { false } }

    context 'show_round_info_text_if_pass_win_and_lose_checks' do
      it { expect(Representer).to receive(:round_info_text) }
    end

    context 'redirect_to_win_if_guess_eq_code' do
      it do
        allow(subject.instance_variable_get(:@game)).to receive(:win?) { true }
        expect(subject).to receive(:win)
      end
    end
  end

  describe 'save_result' do
    it do
      subject.instance_variable_set(:@game, game_double)
      subject.instance_variable_set(:@user, user_double)
      subject.instance_variable_set(:@difficult, difficult_double)
      expect(subject).to receive(:save_to_db)
      subject.send(:save_result)
    end
  end

  describe '#lose' do
    it do
      allow(subject).to receive(:main_menu)
      expect(Representer).to receive(:lose_msg)
      subject.send(:lose)
    end
  end

  describe '#win' do
    before do
      expect(Representer).to receive(:win_msg)
      allow(subject).to receive(:main_menu)
    end

    after { subject.send(:win) }

    it 'with_yes' do
      allow(subject).to receive(:user_input) { Console::ACCEPT_SAVING_RESULT }
      expect(subject).to receive(:save_result)
    end

    it 'with_no' do
      allow(subject).to receive(:user_input) { empty_string }
      expect(subject).to receive(:main_menu)
    end
  end

  describe '#statistics' do
    before { allow(subject).to receive(:main_menu) }
    after { subject.send(:statistics) }

    context 'with_empty_db' do
      it do
        allow(subject).to receive(:sort_db) { empty_string }
        expect(Representer).to receive(:empty_db_msg)
      end
    end

    context 'with_not_empty_db' do
      it do
        stub_const('Uploader::PATH', path_to_test_db)
        expect(Representer).to receive(:show_db)
      end
    end
  end

  describe '#sort_db' do
    it do
      stub_const('Uploader::PATH', path_to_test_db)
      expect(subject.send(:sort_db).first.name).to eq(first_name_when_sort_db)
    end
  end

  describe '#user_input' do
    it do
      expect(subject).to receive_message_chain(:gets, :chomp, :downcase)
      subject.send(:user_input)
    end
  end

  describe '#exit_console' do
    it { expect { subject.send(:exit_console) }.to raise_error(SystemExit) }
  end
end
