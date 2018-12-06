# frozen_string_literal: true

RSpec.describe StatisticsResult do
  let(:user_name) { 'John' }
  let(:difficult) { { attempts: 15, hints: 2, level: 'easy' } }
  let(:game) { double('Game', attempts: 10, hints: 1) }
  let(:statistic) { StatisticsResult.new(name: user_name, difficult: difficult, game: game) }

  describe '.new' do
    it { expect(statistic.name).to eq('John') }
    it { expect(statistic.left_attempts).to eq(10) }
    it { expect(statistic.left_hints).to eq(1) }
    it { expect(statistic.level).to eq('easy') }
    it { expect(statistic.all_attempts).to eq(15) }
    it { expect(statistic.all_hints).to eq(2) }
  end
end
