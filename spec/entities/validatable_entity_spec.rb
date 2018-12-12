# frozen_string_literal: true

RSpec.describe ValidatableEntity do
  let(:subject) { described_class.new }
  let(:some_error) { 'Invalid input' }

  describe '.new' do
    it { expect(subject.instance_variable_get(:@errors)).to eq([]) }
  end

  describe '#validate' do
    it { expect { subject.validate }.to raise_error(NotImplementedError) }
  end

  describe '#valid?' do
    it { expect(subject.valid?).to eq(true) }
  end

  describe '#negative_valid?' do
    it do
      subject.instance_variable_set(:@errors, [some_error])
      expect(subject.valid?).to eq(false)
    end
  end
end
