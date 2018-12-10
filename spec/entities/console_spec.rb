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

    describe 'make_guess_redirect_to_check_result' do
      it do
        allow(subject).to receive(:user_input).and_return('start', 'Nick', 'easy', '1111')
        expect(subject).to receive(:check_result)
      end
    end

    describe 'make_guess_redirect_to_show_hint' do
      it do
        allow(subject).to receive(:user_input).and_return('start', 'Nick', 'easy', 'hint')
        expect(subject).to receive(:show_hint)
      end
    end
  end

  describe 'check_loops' do
    before { expect(subject).to receive(:user_input).exactly(3).times }

    context 'guess_loop' do
      it do
        subject.instance_variable_set(:@game, game)
        allow(subject).to receive(:check_result)
        allow(game).to receive(:start)
        allow(subject).to receive(:user_input).and_return('qqqq', '111', '1111')
        subject.send(:make_guess)
      end
    end

    context 'name_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('', long_name, 'Sam')
        subject.send(:choose_name)
      end
    end

    context 'difficult_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('', 'eeee', 'easy')
        subject.send(:choose_difficult)
      end
    end
  end

  describe 'show_hint' do
    before { allow(subject).to receive(:make_guess) }
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

  describe 'check_result' do
    context 'redirect_to_lose_if_zero_attempts' do
      it do
        subject.instance_variable_set(:@game, Game.new(0, 2))
        expect(subject).to receive(:lose)
        subject.send(:check_result, '1')
      end
    end

    before { subject.instance_variable_set(:@game, Game.new(1, 1)) }

    context 'show_result_if_pass_win_and_lose_checks' do
      it do
        allow(subject).to receive(:make_guess)
        expect(Representer).to receive(:show_result_msg)
        subject.send(:check_result, '')
      end
    end

    context 'redirect_to_win_if_all_guessed' do
      it do
        expect(subject).to receive(:win)
        subject.send(:check_result, Game::ALL_GUESSED)
      end
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
