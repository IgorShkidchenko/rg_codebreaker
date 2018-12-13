# frozen_string_literal: true

RSpec.describe Difficult do
  let(:valid_inputs) do
    [Difficult::DIFFICULTIES[:easy][:level],
     Difficult::DIFFICULTIES[:medium][:level],
     Difficult::DIFFICULTIES[:hell][:level]]
  end

  let(:invalid_inputs) do
    [Difficult::DIFFICULTIES[:easy][:level].succ,
     Difficult::DIFFICULTIES[:medium][:level].succ,
     Difficult::DIFFICULTIES[:hell][:level].succ]
  end

  describe '.find' do
    context 'when valid' do
      it do
        valid_inputs.each do |valid_input|
          expect(described_class.find(valid_input)).not_to eq(nil)
          expect(Difficult::DIFFICULTIES.keys).to include(valid_input.to_sym)
        end
      end
    end

    context 'when invalid' do
      it do
        invalid_inputs.each do |invalid_input|
          expect(described_class.find(invalid_input)).to eq(nil)
          expect(Difficult::DIFFICULTIES.keys).not_to include(invalid_input.to_sym)
        end
      end
    end
  end
end
