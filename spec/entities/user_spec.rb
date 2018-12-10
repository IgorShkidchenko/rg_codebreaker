# frozen_string_literal: true

RSpec.describe User do
  let(:subject) { described_class.new('John') }

  describe '.new' do
    it { expect(subject.name).to eq('John') }
  end

  describe '#validate_and_valid?' do
    context 'valid' do
      it do
        expect do
          subject.validate
          expect(subject.errors).to eq([])
        end.to change { subject.errors.size }.by(0)
      end

      it { expect(subject.valid?).to eq(true) }
    end

    context 'invalid' do
      it do
        subject.instance_variable_set(:@name, '')
        expect do
          subject.validate
          expect(subject.errors).to eq(['Improper size'])
        end.to change { subject.errors.size }.by(1)
      end

      it do
        subject.instance_variable_set(:@errors, [''])
        expect(subject.valid?).to eq(false)
      end
    end
  end
end
