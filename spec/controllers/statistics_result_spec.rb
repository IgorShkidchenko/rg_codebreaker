# frozen_string_literal: true

RSpec.describe StatisticsResult do
  let(:statistic) { StatisticsResult.new(name: 'John', attempts: 15, hints: 2, level: 'easy') }

  it 'check_creation_with_level_easy' do
    expect(statistic.name).to eq('John')
    expect(statistic.attempts).to eq(15)
    expect(statistic.hints).to eq(2)
    expect(statistic.level).to eq('easy')
    expect(statistic.all_attempts).to eq(15)
  end

  context 'check_all_attempts_assignment' do
    it do
      result = StatisticsResult.new(name: 'John', attempts: 15, hints: 2, level: 'medium')
      expect(result.all_attempts).to eq(10)
    end

    it do
      result = StatisticsResult.new(name: 'John', attempts: 15, hints: 2, level: 'hell')
      expect(result.all_attempts).to eq(5)
    end
  end
end
