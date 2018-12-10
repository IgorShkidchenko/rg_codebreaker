# frozen_string_literal: true

RSpec.describe ValidatableEntity do
  let(:subject) { described_class.new }

  describe '#validate' do
    it do
      expect { subject.validate }.to raise_error(NotImplementedError)
    end
  end
end
