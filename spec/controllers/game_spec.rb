# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { Game.new('John', hints: 2, attempts: 15, level: 'easy') }

  context 'check_creation' do
    it { expect(game.name).to eq('John') }
    it { expect(game.attempts).to eq(15) }
    it { expect(game.hints).to eq(2) }
    it { expect(game.level).to eq('easy') }
  end

  context 'check_hint' do
    it { expect(game.breaker_numbers).to include(game.hint) }
    it { expect { game.hint }.to change { game.hints }.by(-1) }
  end

  context 'check_attempts_decrease' do
    it { expect { game.start('1111') }.to change { game.attempts }.by(-1) }
  end

  context 'check_start_with_[1, 2, 3, 4]' do
    before { game.instance_variable_set(:@breaker_numbers, [1, 2, 3, 4]) }

    it do
      guess = '3124'
      result = game.start(guess)
      expect(result).to eq ['+', '-', '-', '-']
    end

    it do
      guess = '1524'
      result = game.start(guess)
      expect(result).to eq ['+', '+', '-']
    end

    it do
      guess = '1234'
      result = game.start(guess)
      expect(result).to eq ['+', '+', '+', '+']
    end
  end

  context 'check_start_with_[6, 5, 4, 3]' do
    before { game.instance_variable_set(:@breaker_numbers, [6, 5, 4, 3]) }

    it do
      guess = '5643'
      result = game.start(guess)
      expect(result).to eq ['+', '+', '-', '-']
    end

    it do
      guess = '6411'
      result = game.start(guess)
      expect(result).to eq ['+', '-']
    end

    it do
      guess = '6544'
      result = game.start(guess)
      expect(result).to eq ['+', '+', '+']
    end

    it do
      guess = '3456'
      result = game.start(guess)
      expect(result).to eq ['-', '-', '-', '-']
    end

    it do
      guess = '6666'
      result = game.start(guess)
      expect(result).to eq ['+']
    end

    it do
      guess = '3456'
      result = game.start(guess)
      expect(result).to eq ['-', '-', '-', '-']
    end

    it do
      guess = '2666'
      result = game.start(guess)
      expect(result).to eq ['-']
    end

    it do
      guess = '2222'
      result = game.start(guess)
      expect(result).to eq []
    end
  end

  it 'check_start_with_[6, 6, 6, 6]' do
    game.instance_variable_set(:@breaker_numbers, [6, 6, 6, 6])
    guess = '1661'
    result = game.start(guess)
    expect(result).to eq ['+', '+']
  end
end
