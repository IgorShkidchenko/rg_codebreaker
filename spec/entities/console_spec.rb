# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  let(:user) { double('User', name: 'John') }
  let(:difficult) { double('Difficult', input: 'easy', level: { attempts: 15, hints: 2, level: 'easy' }) }
  let(:game) { double('Game', attempts: 10, hints: 1) }
  let(:long_name) { 'aaaaaaaaaaaaaaaaaaaaa' }
  let(:statistic) { double('StatisticsResult', name: user.name, difficult: difficult, game: game) }

  describe '.new' do
    it { expect { subject }.to output(/Hello/).to_stdout }
  end

  describe '#what_next' do
    context 'rules' do
      it do
        allow(subject).to receive(:user_input).and_return('rules')
        expect(subject).to receive(:rules)
        subject.what_next
      end
    end

    context 'stats' do
      it do
        allow(subject).to receive(:user_input).and_return('stats')
        expect(subject).to receive(:statistics)
        subject.what_next
      end
    end

    context 'start' do
      it do
        allow(subject).to receive(:user_input).and_return('start')
        expect(subject).to receive(:registration)
        subject.what_next
      end
    end

    context 'check_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('', 'start')
        allow(subject).to receive(:registration)
        expect(subject).to receive(:user_input).twice
        subject.what_next
      end
    end
  end

  describe '#registration' do
    it do
      subject.instance_variable_set(:@difficult, difficult)
      allow(subject).to receive(:choose_name)
      allow(subject).to receive(:choose_difficult)
      expect(subject).to receive(:go_game)
      subject.registration
    end
  end

  describe '#choose_name' do
    it do
      allow(subject).to receive(:user_input).and_return('', long_name, 'Nick')
      expect(subject).to receive(:user_input).exactly(3).times
      subject.choose_name
    end
  end

  describe '#choose_difficult' do
    it do
      allow(subject).to receive(:user_input).and_return('', 'easy')
      expect(subject).to receive(:user_input).twice
      subject.choose_difficult
    end
  end

  describe '#go_game' do
    before do
      subject.instance_variable_set(:@game, game)
      allow(subject).to receive(:check_result)
    end

    context 'check_start_navigate' do
      it do
        allow(subject).to receive(:user_input).and_return('1111')
        expect(game).to receive(:start)
        subject.go_game
      end
    end

    before { allow(game).to receive(:start) }

    context 'check_show_hint_navigate' do
      it do
        allow(subject).to receive(:user_input).and_return('hint')
        allow(game).to receive(:start)
        expect(subject).to receive(:show_hint)
        subject.go_game
      end
    end

    context 'check_loop' do
      it do
        allow(subject).to receive(:user_input).and_return('qqqq', '111', '1111')
        expect(subject).to receive(:user_input).exactly(3).times
        subject.go_game
      end
    end
  end

  describe '#validate_choice' do
    context 'valid' do
      it { expect(subject.validate_choice(Console::COMMANDS[:stats])).to eq(true) }
    end

    context 'invalid' do
      it { expect(subject.validate_choice('')).to eq(nil) }
    end
  end

  describe '#save_result' do
    it do
      subject.instance_variable_set(:@game, game)
      subject.instance_variable_set(:@user, user)
      subject.instance_variable_set(:@difficult, difficult)

      expect(subject).to receive(:save_to_db)
      subject.save_result
    end
  end

  describe '#check_result' do
    it do
      allow(subject).to receive(:go_game)
      expect(subject).to receive(:lose)
      subject.check_result(:lose)
    end
  end

  describe '#check_show_hint' do
    it do
      subject.instance_variable_set(:@game, Game.new(1, 0))
      allow(subject).to receive(:go_game)
      expect(Representer).to receive(:zero_hints_msg)
      subject.show_hint
    end
  end

  describe 'check_console_navigation' do
    before { expect(subject).to receive(:what_next) }

    it { subject.lose }
    it { subject.rules }

    it do
      allow(subject).to receive(:sort_db).and_return([])
      subject.statistics
    end

    it do
      allow(subject).to receive(:gets).and_return('')
      subject.win
    end
  end
end
