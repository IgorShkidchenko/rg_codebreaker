# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:valid_length) { 'a' * User::VALID_NAME_SIZE.first }
  let(:valid_numbers) { Guess::VALID_NUMBERS.first * Game::CODE_SIZE }

  let(:invalid_max_length) { 'a' * (User::VALID_NAME_SIZE.max + 1) }
  let(:invalid_min_length) { 'a' * (User::VALID_NAME_SIZE.min - 1) }
  let(:invalid_numbers_min) { (Game::INCLUDE_IN_GAME_NUMBERS.min - 1).to_s * (Game::CODE_SIZE - 1) }
  let(:invalid_numbers_max) { (Game::INCLUDE_IN_GAME_NUMBERS.max + 1).to_s * (Game::CODE_SIZE + 1) }

  describe 'valid_check' do
    context 'when #check_cover true' do
      it { expect(console.check_cover?(valid_length, User::VALID_NAME_SIZE)).to eq(true) }
    end

    context 'when #check_numbers true' do
      it { expect(console.check_numbers?(valid_numbers, Guess::VALID_NUMBERS)).to eq(true) }
    end

    context 'when #check_size true' do
      it { expect(console.check_size?(valid_numbers, Game::CODE_SIZE)).to eq(true) }
    end

    context 'when #check_include true' do
      it { expect(console.check_include?(Console::COMMANDS[:start], Console::COMMANDS.values)).to eq(true) }
    end
  end

  describe 'invliad_check' do
    context 'when #check_cover_min false' do
      it { expect(console.check_cover?(invalid_min_length, User::VALID_NAME_SIZE)).to eq(false) }
    end

    context 'when #check_cover_max false' do
      it { expect(console.check_cover?(invalid_max_length, User::VALID_NAME_SIZE)).to eq(false) }
    end

    context 'when #check_numbers false?' do
      it { expect(console.check_numbers?(invalid_numbers_min, Guess::VALID_NUMBERS)).to eq(false) }
    end

    context 'when #check_size false?' do
      it { expect(console.check_size?(invalid_min_length, Game::CODE_SIZE)).to eq(false) }
    end

    context 'when #check_include false?' do
      it { expect(console.check_include?(invalid_numbers_max, Guess::VALID_NUMBERS)).to eq(false) }
    end
  end
end
