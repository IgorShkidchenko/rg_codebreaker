# frozen_string_literal: true

RSpec.describe StatisticsResult do
  let(:user_name) { 'John' }
  let(:difficult) { Difficult::DIFFICULTIES[:easy] }
  let(:game) { double('Game', attempts: 10, hints: 1) }
  let(:statistic) { described_class.new(name: user_name, difficult: difficult, game: game) }

  describe '.new' do
    it { expect(statistic.name).to eq('John') }
    it { expect(statistic.left_attempts).to eq(10) }
    it { expect(statistic.left_hints).to eq(1) }
    it { expect(statistic.level).to eq('easy') }
    it { expect(statistic.all_attempts).to eq(15) }
    it { expect(statistic.all_hints).to eq(2) }
  end
end
