# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  context '.check_creation' do
    it { expect { subject }.to output(/Hello/).to_stdout }
  end

  describe '.what_next' do
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

  #    it 'check' do
  #      allow(subject).to receive(:what_next).and_return(:registration)
  #      expect(subject).to receive(:validated_name)
  #      subject.what_next
  #    end

  #   context 'check_registration' do
  #     it do
  #       allow(subject).to receive(:go_game)
  #       allow(subject).to receive(:validated_name).and_return('Nick')
  #       allow(subject).to receive(:select_difficult).and_return(hints: 2, attempts: 15, level: 'easy')
  #       expect { subject.registration }.to output(/You log in as Nick/).to_stdout
  #     end
  #   end

  #   context 'check_show_hint' do
  #     let(:game) { Game.new('John', hints: 2, attempts: 15, level: 'easy') }

  #     before do
  #       allow(subject).to receive(:go_game)
  #     end

  #     it 'check_with_some_hints' do
  #       subject.instance_variable_set(:@game, game)
  #       expect { subject.show_hint }.to output(/Code contains this number: /).to_stdout
  #     end

  #     it 'check_with_zero_hints' do
  #       game.instance_variable_set(:@hints, 0)
  #       subject.instance_variable_set(:@game, game)
  #       expect { subject.show_hint }.to output(/You don't have any hints/).to_stdout
  #     end
  #   end

  #   # expect { subject.save_to_db }.to change { subject.load_db.count }.by(1)
  #   # context 'check_go_game' do
  #   #   before do
  #   #     allow(subject).to receive(:select_difficult).and_return(hints: 2, attempts: 1, level: 'easy')
  #   #     allow(subject).to receive(:validated_guess)
  #   #   end

  #   context 'check_difficult' do
  #     it 'check_easy' do
  #       allow(subject).to receive(:validated_difficult).and_return('easy')
  #       expect(subject.select_difficult).to eq(hints: 2, attempts: 15, level: 'easy')
  #     end

  #     it 'check_medium' do
  #       allow(subject).to receive(:validated_difficult).and_return('medium')
  #       expect(subject.select_difficult).to eq(hints: 1, attempts: 10, level: 'medium')
  #     end

  #     it 'check_hell' do
  #       allow(subject).to receive(:validated_difficult).and_return('hell')
  #       expect(subject.select_difficult).to eq(hints: 1, attempts: 5, level: 'hell')
  #     end
  #   end
end
