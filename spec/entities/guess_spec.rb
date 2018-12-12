# frozen_string_literal: true

RSpec.describe Guess do
  let(:valid_guess) { Guess::VALID_NUMBERS.sample(4).join }
  let(:subject) { described_class.new(valid_guess) }
  let(:invalid_guess) { '777' }

  describe '.new' do
    it { expect(subject.input).to eq(valid_guess) }
    it { expect(subject.instance_variable_get(:@errors)).to eq([]) }
  end

  describe '#as_array_of_numbers' do
    it { expect(subject.as_array_of_numbers).to eq(valid_guess.chars.map(&:to_i)) }
  end

  describe 'valid_check' do
    before { subject.validate }

    context '#validate' do
      it { expect(subject.errors.empty?).to eq(true) }
    end

    context '#valid?' do
      it { expect(subject.valid?).to eq(true) }
    end

    context '#hint?' do
      it do
        subject.instance_variable_set(:@input, Guess::HINT)
        expect(subject.valid?).to eq(true)
      end
    end
  end

  describe 'invalid_check' do
    before do
      subject.instance_variable_set(:@input, invalid_guess)
      subject.validate
    end

    context '#validate' do
      it { expect(subject.errors).to eq([I18n.t('invalid.include_error'), I18n.t('invalid.size_error')]) }
    end

    context '#valid?' do
      it { expect(subject.valid?).to eq(false) }
    end

    context '#hint?' do
      it do
        subject.instance_variable_set(:@input, Guess::HINT.succ)
        expect(subject.valid?).to eq(false)
      end
    end
  end
end
