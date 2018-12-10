# frozen_string_literal: true

RSpec.describe User do
  let(:user) { User.new('John') }

  describe '.new' do
    it { expect(user.name).to eq('John') }
  end

  describe '#valid' do
    context 'valid' do
      it { expect(user.validate).to eq(nil) }
    end

    context 'invalid' do
      it do
        user.instance_variable_set(:@name, '')
        expect { user.validate }.to raise_error(Errors::CoverError)
      end
    end
  end
end
