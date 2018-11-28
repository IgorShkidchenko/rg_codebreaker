# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  describe '#check_difficult_module' do
    it 'check_easy' do
      allow(subject).to receive(:validated_difficult).and_return('easy')
      expect(subject.select_difficult).to eq(hints: 2, attempts: 15, level: 'easy')
    end

    it 'check_medium' do
      allow(subject).to receive(:validated_difficult).and_return('medium')
      expect(subject.select_difficult).to eq(hints: 1, attempts: 10, level: 'medium')
    end

    it 'check_hell' do
      allow(subject).to receive(:validated_difficult).and_return('hell')
      expect(subject.select_difficult).to eq(hints: 1, attempts: 5, level: 'hell')
    end
  end
end
