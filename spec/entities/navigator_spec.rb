# frozen_string_literal: true

RSpec.describe Navigator do
  let(:subject) { described_class.new(Console::COMMANDS[:start]) }
  let(:valid_inputs) { [Console::COMMANDS[:start], Console::COMMANDS[:stats], Console::COMMANDS[:rules]] }
  let(:invalid_input) { Console::COMMANDS[:start].succ }

  describe '.new' do
    it { expect(subject.input).to eq(Console::COMMANDS[:start]) }
  end

  describe 'valid' do
    before { subject.validate }

    context 'check_valid_inputs_include_in_COMMANDS' do
      it do
        valid_inputs.each do |valid_input|
          subject.instance_variable_set(:@input, valid_input)
          expect(subject.errors.empty?).to eq(true)
        end
      end
    end

    context '#valid?' do
      it { expect(subject.valid?).to eq(true) }
    end
  end

  describe 'invalid' do
    before do
      subject.instance_variable_set(:@input, invalid_input)
      subject.validate
    end

    context '#validate' do
      it { expect(subject.errors).to eq([I18n.t('invalid.include_error')]) }
    end

    context '#valid?' do
      it { expect(subject.valid?).to eq(false) }
    end
  end
end
