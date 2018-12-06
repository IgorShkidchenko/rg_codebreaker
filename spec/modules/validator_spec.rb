# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  describe '#valid_check' do
    context '#valid_check_match' do
      it { expect(subject.check_match?('hint', Guess::HINT)).to eq(true) }
    end

    context '#valid_check_numbers' do
      it { expect(subject.check_numbers?('1234', Guess::VALID_NUMBERS)).to eq(true) }
    end

    context '#valid_check_size' do
      it { expect(subject.check_size?('1111', Guess::VALID_SIZE)).to eq(true) }
    end

    context '#valid_check_include' do
      it { expect(subject.check_include?(1, [1, 2])).to eq(true) }
    end
  end

  describe '#invliad_check' do
    context '#invalid_check_match' do
      it { expect(subject.check_match?('', Guess::HINT)).to eq(false) }
    end

    context '#invalid_check_numbers' do
      it { expect(subject.check_numbers?('eeee', Guess::VALID_NUMBERS)).to eq(false) }
    end

    context '#invalid_check_size' do
      it { expect(subject.check_size?('12345', Guess::VALID_SIZE)).to eq(false) }
    end

    context '#invalid_check_include' do
      it { expect(subject.check_include?(3, [1, 2])).to eq(false) }
    end
  end
end
