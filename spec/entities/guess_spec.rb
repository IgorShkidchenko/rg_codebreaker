# frozen_string_literal: true

RSpec.describe Guess do
  let(:subject) { described_class.new('1111') }

  describe '.new' do
    it { expect(subject.input).to eq('1111') }
  end

  describe '#make_array_of_numbers' do
    it { expect(subject.make_array_of_numbers).to eq([1, 1, 1, 1]) }
  end

  describe '#validate' do
    context 'valid' do
      it { expect(subject.validate).to eq(nil) }

      it do
        subject.instance_variable_set(:@input, Guess::HINT)
        expect do
          subject.validate
          expect(subject.errors).to eq([])
        end.to change { subject.errors.size }.by(0)
      end

      it { expect(subject.valid?).to eq(true) }
    end

    context 'invalid' do
      it do
        subject.instance_variable_set(:@input, '777')
        expect do
          subject.validate
          expect(subject.errors).to eq(['Not include in propose inputs', 'Invalid size'])
        end.to change { subject.errors.size }.by(2)
      end
    end
  end
end
