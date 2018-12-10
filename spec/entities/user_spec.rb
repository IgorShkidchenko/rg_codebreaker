# frozen_string_literal: true

RSpec.describe User do
  let(:user) { User.new('John') }

  describe '.new' do
    it { expect(user.name).to eq('John') }
  end

  describe '#valid_name' do
    context 'valid' do
      it { expect(user.validate_name).to eq(nil) }
    end

    context 'invalid' do
      it do
        user.instance_variable_set(:@name, '')
        expect { user.validate_name }.to raise_error(Errors::CoverError)
      end
    end
  end
end
