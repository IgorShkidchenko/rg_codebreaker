# frozen_string_literal: true

RSpec.describe Difficult do
  let(:difficult) { Difficult.new('easy') }

  describe '#validate_level' do
    context 'valid' do
      it { expect(difficult.validate_level).to eq(Difficult::DIFFICULTS[:easy]) }
    end

    context 'invalid' do
      it do
        difficult.instance_variable_set(:@input, '')
        expect { difficult.validate_level }.to raise_error(Errors::IncludeError)
      end
    end
  end

  describe '#select_difficult' do
    context 'level_easy' do
      it do
        difficult.select_difficult
        expect(difficult.level).to eq(Difficult::DIFFICULTS[:easy])
      end
    end

    context 'level_medium' do
      it do
        difficult.instance_variable_set(:@input, 'medium')
        difficult.select_difficult
        expect(difficult.level).to eq(Difficult::DIFFICULTS[:medium])
      end
    end

    context 'level_hell' do
      it do
        difficult.instance_variable_set(:@input, 'hell')
        difficult.select_difficult
        expect(difficult.level).to eq(Difficult::DIFFICULTS[:hell])
      end
    end
  end
end
