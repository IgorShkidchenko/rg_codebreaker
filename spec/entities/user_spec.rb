# frozen_string_literal: true

RSpec.describe User do
  let(:valid_name) { 'John' }
  let(:subject) { described_class.new(valid_name) }
  let(:empty_string) { '' }

  describe '.new' do
    it { expect(subject.name).to eq(valid_name) }
    it { expect(subject.instance_variable_get(:@errors)).to eq([]) }
  end

  describe 'valid' do
    before { subject.validate }

    context '#validate' do
      it { expect(subject.errors.empty?).to eq(true) }
    end

    context '#valid?' do
      it { expect(subject.valid?).to eq(true) }
    end
  end

  describe 'invalid' do
    before do
      subject.instance_variable_set(:@name, empty_string)
      subject.validate
    end

    context '#validate' do
      it { expect(subject.errors).to eq([I18n.t('invalid.cover_error')]) }
    end

    context '#valid?' do
      it { expect(subject.valid?).to eq(false) }
    end
  end
end
