# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  it 'check_lose' do
    allow(subject).to receive(:what_next)
    expect { subject.lose }.to output(/Game over, you lose if you want you can start a new game/).to_stdout
  end

  it 'check_win' do
    allow(subject).to receive(:what_next)
    allow(subject).to receive(:gets).and_return('')
    expect { subject.win }.to output(/You win/).to_stdout
  end

  before do
    allow(subject).to receive(:validated_name).and_return('Nick')
    allow(subject).to receive(:select_difficult).and_return(hints: 2, attempts: 15, level: 'easy')
  end

  context 'check_registration_and_save_to_db' do
    it do
      subject.reg_first_step
      expect(subject.name).to eq('Nick')
    end

    it do
      subject.reg_second_step
      expect(subject.hints).to eq(2)
      expect(subject.attempts).to eq(15)
      expect(subject.level).to eq('easy')
    end

    it do
      subject.registration
      expect { subject.save_to_db }.to change { subject.load_db.count }.by(1)
    end
  end

  context 'check_show_hint' do
    before do
      allow(subject).to receive(:go_game)
    end

    it 'check_with_some_hints' do
      subject.registration
      expect { subject.show_hint }.to change { subject.hints }.by(-1)
      expect(subject.hints).to eq 1
    end

    it 'check_with_zero_hints' do
      allow(subject).to receive(:select_difficult).and_return(hints: 0)
      subject.registration
      expect { subject.show_hint }.to output(/You don't have any hints/).to_stdout
      expect(subject.hints).to eq 0
    end
  end

  context 'check_go_game' do
    before do
      allow(subject).to receive(:select_difficult).and_return(hints: 2, attempts: 1, level: 'easy')
      allow(subject).to receive(:validated_guess)
    end

    it 'check_attempts_decrease' do
      allow(subject).to receive(:start)
      allow(subject).to receive(:lose)
      subject.registration
      expect(subject.attempts).to eq 1
      expect { subject.go_game }.to output(/Your result is /).to_stdout
      expect(subject.attempts).to eq 0
    end
  end
end
