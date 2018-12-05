# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  describe '#valid_check' do
    context '#valid_choice' do
      it { expect(subject.valid_choice(Console::COMMANDS[:stats])).to eq(true) }
    end

    context '#valid_name' do
      it { expect(subject.valid_name('john')).to eq(true) }
    end

    context '#valid_difficult' do
      it { expect(subject.valid_difficult(Console::LEVELS[:easy])).to eq(true) }
    end

    context '#valid_check_match' do
      it { expect(subject.check_match?('hint', Guess::HINT)).to eq(true) }
    end

    context '#valid_check_class' do
      it { expect(subject.check_class?('', String)).to eq(true) }
    end

    context '#valid_check_numbers' do
      it { expect(subject.check_numbers?('1234', Guess::VALID_NUMBERS)).to eq(true) }
    end

    context '#valid_check_size' do
      it { expect(subject.check_size?('1111', Guess::VALID_SIZE)).to eq(true) }
    end
  end

  describe '#invliad_check' do
    context '#invalid_choice' do
      it { expect(subject.valid_choice('')).to eq(nil) }
      it { expect(subject.valid_choice(1)).to eq(false) }
    end

    context '#invalid_name' do
      it { expect(subject.valid_name('')).to eq(nil) }
      it { expect(subject.valid_name(1)).to eq(false) }
    end

    context '#invalid_difficult' do
      it { expect(subject.valid_difficult('')).to eq(nil) }
      it { expect(subject.valid_difficult(1)).to eq(false) }
    end

    context '#invalid_check_match' do
      it { expect(subject.check_match?('', Guess::HINT)).to eq(false) }
    end

    context '#invalid_check_class' do
      it { expect(subject.check_class?(1, String)).to eq(false) }
    end

    context '#invalid_check_numbers' do
      it { expect(subject.check_numbers?('eeee', Guess::VALID_NUMBERS)).to eq(false) }
    end

    context '#invalid_check_size' do
      it { expect(subject.check_size?('12345', Guess::VALID_SIZE)).to eq(false) }
    end
  end
end
