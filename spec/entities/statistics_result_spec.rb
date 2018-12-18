# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe StatisticsResult do
    subject(:statistic) { described_class.new(user: user, difficulty: difficulty, game: game) }

    let(:user) { instance_double('User', name: 'John') }
    let(:difficulty) { instance_double('difficulty', level: Difficulty::DIFFICULTIES[:easy]) }
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
end
