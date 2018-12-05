# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  let(:user) { double('User', name: 'John', difficult: { attempts: 15, hints: 2, level: 'easy' }) }
  let(:game) { double('Game', attempts: 10, hints: 1) }

  context '.check_creation' do
    it { expect { subject }.to output(/Hello/).to_stdout }
  end

  describe '#what_next' do
    context 'rules' do
      it do
        allow(subject).to receive(:gets).and_return('rules')
        expect(subject).to receive(:rules)
        subject.what_next
      end
    end

    context 'stats' do
      it do
        allow(subject).to receive(:gets).and_return('stats')
        expect(subject).to receive(:statistics)
        subject.what_next
      end
    end

    context 'start' do
      it do
        allow(subject).to receive(:gets).and_return('start')
        expect(subject).to receive(:registration)
        subject.what_next
      end
    end
  end

  context '#check_registration' do
    it do
      allow(subject).to receive(:go_game)
      allow(subject).to receive(:select_name).and_return(user.name)
      allow(subject).to receive(:select_difficult).and_return(user.difficult)
      subject.registration
      expect(subject.user.name).to eq(user.name)
    end
  end

  context '#check_select_name' do
    it do
      allow(subject).to receive(:user_input).and_return('', 'Nick')
      expect(subject).to receive(:user_input).twice
      subject.select_name
    end
  end

  context '#check_difficult' do
    it do
      allow(subject).to receive(:gets).and_return('easy')
      expect(subject.select_difficult).to eq(attempts: 15, hints: 2, level: 'easy')
    end

    it do
      allow(subject).to receive(:gets).and_return('medium')
      expect(subject.select_difficult).to eq(hints: 1, attempts: 10, level: 'medium')
    end

    it do
      allow(subject).to receive(:gets).and_return('hell')
      expect(subject.select_difficult).to eq(hints: 1, attempts: 5, level: 'hell')
    end
  end

  context '#check_result' do
    it do
      allow(subject).to receive(:go_game)
      expect(subject).to receive(:lose)
      subject.check_result(:lose)
    end
  end

  context '#check_show_hint' do
    it do
      subject.instance_variable_set(:@game, Game.new(1, 0))
      allow(subject).to receive(:go_game)
      expect(Representer).to receive(:zero_hints_msg)
      subject.show_hint
    end
  end

  context 'unnecessary' do
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
