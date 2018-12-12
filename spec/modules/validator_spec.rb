# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  let(:valid_length) { 'John' }
  let(:valid_numbers) { '1234' }

  let(:invalid_max_length) { valid_length * 10 }
  let(:invalid_min_length) { valid_length.slice(0, 1) }
  let(:invalid_numbers) { '9999' }

  describe 'valid_check' do
    context '#check_cover' do
      it { expect(subject.check_cover?(valid_length, User::VALID_NAME_SIZE)).to eq(true) }
    end

    context '#check_numbers' do
      it { expect(subject.check_numbers?(valid_numbers, Guess::VALID_NUMBERS)).to eq(true) }
    end

    context '#check_size' do
      it { expect(subject.check_size?(valid_length, Game::CODE_SIZE)).to eq(true) }
    end

    context '#check_include' do
      it { expect(subject.check_include?(valid_numbers.slice(0, 1), Guess::VALID_NUMBERS)).to eq(true) }
    end
  end

  describe 'invliad_check' do
    context '#check_cover_min' do
      it { expect(subject.check_cover?(invalid_min_length, User::VALID_NAME_SIZE)).to eq(false) }
    end

    context '#check_cover_max' do
      it { expect(subject.check_cover?(invalid_max_length, User::VALID_NAME_SIZE)).to eq(false) }
    end

    context '#check_numbers?' do
      it { expect(subject.check_numbers?(invalid_numbers, Guess::VALID_NUMBERS)).to eq(false) }
    end

    context '#check_size?' do
      it { expect(subject.check_size?(invalid_min_length, Game::CODE_SIZE)).to eq(false) }
    end

    context '#check_include?' do
      it { expect(subject.check_include?(invalid_numbers.slice(0, 1), Guess::VALID_NUMBERS)).to eq(false) }
    end
  end
end
