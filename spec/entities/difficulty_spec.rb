# frozen_string_literal: true

RSpec.describe Difficulty do
  let(:valid_inputs) do
    [Difficulty::DIFFICULTIES[:easy][:level],
     Difficulty::DIFFICULTIES[:medium][:level],
     Difficulty::DIFFICULTIES[:hell][:level]]
  end

  let(:invalid_inputs) do
    [Difficulty::DIFFICULTIES[:easy][:level].succ,
     Difficulty::DIFFICULTIES[:medium][:level].succ,
     Difficulty::DIFFICULTIES[:hell][:level].succ]
  end

  describe '.find' do
    context 'when valid' do
      it do
        valid_inputs.each do |valid_input|
          expect(described_class.find(valid_input)).not_to eq(nil)
          expect(Difficulty::DIFFICULTIES.keys).to include(valid_input.to_sym)
        end
      end
    end

    context 'when invalid' do
      it do
        invalid_inputs.each do |invalid_input|
          expect(described_class.find(invalid_input)).to eq(nil)
          expect(Difficulty::DIFFICULTIES.keys).not_to include(invalid_input.to_sym)
        end
      end
    end
  end
end
