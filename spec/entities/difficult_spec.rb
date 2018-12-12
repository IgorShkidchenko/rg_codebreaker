# frozen_string_literal: true

RSpec.describe Difficult do
  let(:valid_inputs) { %w[easy medium hell] }
  let(:invalid_inputs) { %w[e11asy med22ium hell22] }
  let(:subject) { described_class.new('easy') }

  describe '.find' do
    context 'valid' do
      it do
        valid_inputs.each do |valid_input|
          expect(Difficult.find(valid_input)).not_to eq(nil)
          expect(Difficult::DIFFICULTIES.keys).to include(valid_input.to_sym)
        end
      end
    end

    context 'invalid' do
      it do
        invalid_inputs.each do |invalid_input|
          expect(Difficult.find(invalid_input)).to eq(nil)
          expect(Difficult::DIFFICULTIES.keys).not_to include(invalid_input.to_sym)
        end
      end
    end
  end
end
