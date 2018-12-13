# frozen_string_literal: true

RSpec.describe Game do
  subject(:game) { described_class.new(attempts, hints) }

  let(:attempts) { Difficult::DIFFICULTIES[:easy][:attempts] }
  let(:hints) { Difficult::DIFFICULTIES[:easy][:hints] }
  let(:guess_place) { Game::GUESS_PLACE }
  let(:guess_presence) { Game::GUESS_PRESENCE }

  describe '.new' do
    it { expect(game.attempts).to eq(attempts) }
    it { expect(game.hints).to eq(hints) }
  end

  describe '#hint' do
    context 'when check_hint_including_in_code' do
      it { expect(game.instance_variable_get(:@breaker_numbers)).to include(game.hint) }
    end

    context 'when check_hints_decrease' do
      it { expect { game.hint }.to change(game, :hints).by(-1) }
    end

    context 'when check_hints_return_nil_with_zero_hints' do
      it do
        game.instance_variable_set(:@hints, 0)
        expect(game.hint).to eq(nil)
      end
    end
  end

  describe 'check_attempts_decrease' do
    it { expect { game.start_round([1, 1, 1, 1]) }.to change(game, :attempts).by(-1) }
  end

  describe '#lose?' do
    before do
      game.instance_variable_set(:@breaker_numbers, [6, 6, 6, 6])
      game.instance_variable_set(:@attempts, 1)
    end

    context 'when lose_eq_false' do
      it { expect(game.lose?).to eq false }
    end

    context 'when lose_eq_true' do
      it do
        game.start_round([1, 2, 3, 4])
        expect(game.lose?).to eq true
      end
    end
  end

  describe '#win?' do
    let(:guess) { [1, 2, 3, 4] }
    let(:numbers_for_lose) { [1, 1, 1, 1] }

    before { game.instance_variable_set(:@breaker_numbers, [1, 2, 3, 4]) }

    context 'when win_eq_all_guessed' do
      it { expect(game.instance_variable_get(:@breaker_numbers)).to eq(guess) }
    end

    context 'when win_eq_true' do
      it { expect(game.win?(guess)).to eq true }
    end

    context 'when win_eq_false' do
      it { expect(game.win?(numbers_for_lose)).to eq false }
    end
  end

  describe '#check_start_round_with_[1, 2, 3, 4]' do
    before { game.instance_variable_set(:@breaker_numbers, [1, 2, 3, 4]) }

    it do
      guess = [3, 1, 2, 4]
      expect(game.start_round(guess)).to eq [guess_place, guess_presence, guess_presence, guess_presence]
    end

    it do
      guess = [1, 5, 2, 4]
      expect(game.start_round(guess)).to eq [guess_place, guess_place, guess_presence]
    end
  end

  describe '#check_start_round_with_[6, 5, 4, 3]' do
    before { game.instance_variable_set(:@breaker_numbers, [6, 5, 4, 3]) }

    context 'when with_pluses' do
      it do
        guess = [5, 6, 4, 3]
        expect(game.start_round(guess)).to eq [guess_place, guess_place, guess_presence, guess_presence]
      end

      it do
        guess = [6, 4, 1, 1]
        expect(game.start_round(guess)).to eq [guess_place, guess_presence]
      end

      it do
        guess = [6, 5, 4, 4]
        expect(game.start_round(guess)).to eq [guess_place, guess_place, guess_place]
      end

      it do
        guess = [6, 6, 6, 6]
        expect(game.start_round(guess)).to eq [guess_place]
      end
    end

    context 'when with_minuses' do
      it do
        guess = [3, 4, 5, 6]
        expect(game.start_round(guess)).to eq [guess_presence, guess_presence, guess_presence, guess_presence]
      end

      it do
        guess = [2, 6, 6, 6]
        expect(game.start_round(guess)).to eq [guess_presence]
      end

      it do
        guess = [2, 2, 2, 2]
        expect(game.start_round(guess)).to eq []
      end
    end
  end

  describe '#check_start_round_with_[6, 6, 6, 6]' do
    it do
      game.instance_variable_set(:@breaker_numbers, [6, 6, 6, 6])
      guess = [1, 6, 6, 1]
      expect(game.start_round(guess)).to eq [guess_place, guess_place]
    end
  end

  describe 'ruby_garage_tests' do
    [
      [[6, 5, 4, 1], [6, 5, 4, 1], [Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PLACE]],
      [[1, 2, 2, 1], [2, 1, 1, 2], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE,
                                    Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[6, 2, 3, 5], [2, 3, 6, 5], [Game::GUESS_PLACE, Game::GUESS_PRESENCE,
                                    Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [4, 3, 2, 1], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE,
                                    Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [1, 2, 3, 5], [Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PLACE]],
      [[1, 2, 3, 4], [5, 4, 3, 1], [Game::GUESS_PLACE, Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [1, 5, 2, 4], [Game::GUESS_PLACE, Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [4, 3, 2, 6], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [3, 5, 2, 5], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [5, 6, 1, 2], [Game::GUESS_PRESENCE, Game::GUESS_PRESENCE]],
      [[5, 5, 6, 6], [5, 6, 0, 0], [Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [6, 2, 5, 4], [Game::GUESS_PLACE, Game::GUESS_PLACE]],
      [[1, 2, 3, 1], [1, 1, 1, 1], [Game::GUESS_PLACE, Game::GUESS_PLACE]],
      [[1, 1, 1, 5], [1, 2, 3, 1], [Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [4, 2, 5, 5], [Game::GUESS_PLACE, Game::GUESS_PRESENCE]],
      [[1, 2, 3, 4], [5, 6, 3, 5], [Game::GUESS_PLACE]],
      [[1, 2, 3, 4], [6, 6, 6, 6], []],
      [[1, 2, 3, 4], [2, 5, 5, 2], [Game::GUESS_PRESENCE]]
    ].each do |item|
      it "should return #{item[2]} if code is - #{item[0]}, atttempt_code is #{item[1]}" do
        game.instance_variable_set(:@breaker_numbers, item[0])
        guess = item[1]
        expect(game.start_round(guess)).to eq item[2]
      end
    end
  end
end
