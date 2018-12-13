# frozen_string_literal: true

RSpec.describe StatisticsResult do
  subject(:statistic) { described_class.new(name: user_name, difficult: difficult.level, game: game) }

  let(:user_name) { 'John' }
  let(:difficult) { instance_double('Difficult', level: Difficult::DIFFICULTIES[:easy]) }
  let(:game) { instance_double('Game', attempts: 10, hints: 1) }

  describe '.new' do
    it { expect(statistic.name).to eq('John') }
    it { expect(statistic.left_attempts).to eq(10) }
    it { expect(statistic.left_hints).to eq(1) }
    it { expect(statistic.level).to eq('easy') }
    it { expect(statistic.all_attempts).to eq(15) }
    it { expect(statistic.all_hints).to eq(2) }
  end
end
