# frozen_string_literal: true

RSpec.describe ValidatableEntity do
  subject(:validatable_entity) { described_class.new }

  let(:some_error) { 'Invalid input' }

  describe '.new' do
    it { expect(validatable_entity.instance_variable_get(:@errors)).to eq([]) }
  end

  describe 'when #validate true' do
    it { expect { validatable_entity.validate }.to raise_error(NotImplementedError) }
  end

  describe 'when #valid? true' do
    it { expect(validatable_entity.valid?).to eq(true) }
  end

  describe 'when #valid? false' do
    it do
      validatable_entity.instance_variable_set(:@errors, [some_error])
      expect(validatable_entity.valid?).to eq(false)
    end
  end
end
