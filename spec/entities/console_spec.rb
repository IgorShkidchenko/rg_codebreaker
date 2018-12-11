# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  let(:user) { double('User', name: 'John') }
  let(:difficult) { double('Difficult', input: 'easy', level: Difficult::DIFFICULTS[:easy]) }
  let(:game) { double('Game', attempts: 10, hints: 1) }
  let(:long_name) { 'aaaaaaaaaaaaaaaaaaaaa' }

  describe 'greating' do
    it do
      expect(Representer).to receive(:greeting_msg)
      subject.greeting
    end
  end

  describe 'navigate' do
    after { subject.main_menu }

    describe '#main_menu' do
      context 'invalid' do
        it do
          allow(subject).to receive(:user_input).and_return('', '', 'start')
          allow(subject).to receive(:registration)
          expect(Representer).to receive(:error_msg).twice
        end
      end

      context 'show_rules_redirect' do
        it do
          allow(subject).to receive(:user_input).and_return('rules', 'start')
          allow(subject).to receive(:registration)
          expect(Representer).to receive(:show_rules)
        end
      end

      context 'statistics_redirect' do
        it do
          allow(subject).to receive(:user_input).and_return('stats', 'start')
          allow(subject).to receive(:registration)
          expect(subject).to receive(:statistics)
        end
      end

      context 'registration_redirect' do
        it do
          allow(subject).to receive(:user_input).and_return('start')
          expect(subject).to receive(:registration)
        end
      end
    end

    context 'redirect_to_make_guess' do
      it do
        allow(subject).to receive(:user_input).and_return('start', 'Nick', 'easy')
        expect(subject).to receive(:make_guess)
      end
    end
  end

  describe 'validate_input_for' do
    before { expect(subject).to receive(:user_input).exactly(3).times }

    context 'guess_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('qqqq', '111', '1111')
        subject.send(:validate_input_for, Guess)
      end
    end

    context 'name_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('', long_name, 'Sam')
        subject.send(:validate_input_for, User)
      end
    end

    context 'difficult_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('', 'eeee', 'easy')
        subject.send(:validate_input_for, Difficult)
      end
    end
  end

  describe 'show_hint' do
    after { subject.send(:show_hint) }

    context 'with_zero_hints' do
      it do
        subject.instance_variable_set(:@game, Game.new(1, 0))
        expect(Representer).to receive(:zero_hints_msg)
      end
    end

    context 'with_some_hints' do
      it do
        subject.instance_variable_set(:@game, Game.new(1, 1))
        expect(Representer).to receive(:showed_hint_msg)
      end
    end
  end

  describe 'show_result_if_pass_win_and_lose_checks' do
    it do
      subject.instance_variable_set(:@game, Game.new(0, 0))
      subject.instance_variable_set(:@guess, Guess.new('1111'))
      allow(game).to receive(:start)
      expect(Representer).to receive(:game_info_text)
      subject.send(:check_game_result)
    end
  end

  describe 'save_result' do
    it do
      subject.instance_variable_set(:@game, game)
      subject.instance_variable_set(:@user, user)
      subject.instance_variable_set(:@difficult, difficult)
      expect(subject).to receive(:save_to_db)
      subject.send(:save_result)
    end
  end

  describe 'win_and_lose' do
    before { allow(subject).to receive(:main_menu) }

    context 'lose' do
      it do
        expect(Representer).to receive(:lose_msg)
        subject.send(:lose)
      end
    end

    context 'win' do
      before { expect(Representer).to receive(:win_msg) }
      after { subject.send(:win) }

      it 'with_yes' do
        allow(subject).to receive(:gets).and_return(Console::ACCEPT_SAVING_RESULT)
        expect(subject).to receive(:save_result)
      end

      it 'with_no' do
        allow(subject).to receive(:gets).and_return('')
        expect(subject).to receive(:main_menu)
      end
    end
  end

  describe 'statistics' do
    it do
      allow(subject).to receive(:main_menu)
      allow(subject).to receive(:sort_db).and_return([])
      allow(Representer).to receive(:empty_db_msg)
      subject.send(:statistics)
    end
  end

  describe 'exit_console' do
    it { expect { subject.send(:exit_console) }.to raise_error(SystemExit) }
  end
end
