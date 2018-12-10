# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  describe 'valid_check' do
    context '#check_cover' do
      it { expect(subject.check_cover?('John', User::VALID_NAME_SIZE)).to eq(true) }
    end

    context '#check_numbers' do
      it { expect(subject.check_numbers?('1234', Guess::VALID_NUMBERS)).to eq(true) }
    end

    context '#check_size' do
      it { expect(subject.check_size?('1111', Game::CODE_SIZE)).to eq(true) }
    end

    context '#check_include' do
      it { expect(subject.check_include?('1', Guess::VALID_NUMBERS)).to eq(true) }
    end
  end

  describe 'invliad_check' do
    context '#check_cover' do
      it { expect(subject.check_cover?('Jo', User::VALID_NAME_SIZE)).to eq(false) }
    end

    context '#check_numbers?' do
      it { expect(subject.check_numbers?('eeee', Guess::VALID_NUMBERS)).to eq(false) }
    end

    context '#check_size?' do
      it { expect(subject.check_size?('12345', Game::CODE_SIZE)).to eq(false) }
    end

    context '#check_include?' do
      it { expect(subject.check_include?(7, Guess::VALID_NUMBERS)).to eq(false) }
    end
  end
end
