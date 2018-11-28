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

  context 'check_registration_and_save_to_db' do
    before do
      allow(subject).to receive(:validated_name).and_return('Nick')
      allow(subject).to receive(:select_difficult).and_return({hints: 2, attempts: 15, level: 'easy'})
    end

    it 'check_reg_first_step' do
      subject.reg_first_step
      expect(subject.name).to eq('Nick')
    end
  
    it 'check_reg_second_step' do
      subject.reg_second_step
      expect(subject.hints).to eq(2)
      expect(subject.attempts).to eq(15)
      expect(subject.level).to eq('easy')
    end

    it 'test' do 
      subject.registration 
      expect { subject.save_to_db }.to change { subject.load_db.count }.by(1)
    end
  end
end
