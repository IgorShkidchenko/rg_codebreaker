# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }
  
  describe '#check_validator_module' do
    context 'valid_input' do
      it 'check_validated_name' do
        allow(subject).to receive(:gets).and_return('john')
        expect(subject.validated_name).to eq('John')
      end

      it 'check_exit_from_validated_name' do
        allow(subject).to receive(:gets).and_return('exit')
        expect { subject.validated_name }.to output(/Goodbye/).to_stdout
      end

      it 'check_exit_from_validated_choice' do
        allow(subject).to receive(:gets).and_return('exit')
        expect { subject.what_next }.to output(/Goodbye/).to_stdout
      end

      it 'check_validated_difficult' do
        allow(subject).to receive(:gets).and_return('easy')
        expect(subject.validated_difficult).to eq('easy')
      end

      it 'check_exit_from_validated_difficult' do
        allow(subject).to receive(:gets).and_return('exit')
        expect { subject.validated_difficult }.to output(/Goodbye/).to_stdout
      end

      it 'check_validated_guess' do
        allow(subject).to receive(:gets).and_return('1234')
        expect(subject.validated_guess).to eq('1234')
      end

      it 'check_exit_from_validated_guess' do
        allow(subject).to receive(:gets).and_return('exit')
        expect { subject.validated_guess }.to output(/Goodbye/).to_stdout
      end

      it 'check_guess_error' do
        allow(subject).to receive(:validated_guess)
        expect { subject.guess_error }.to output(/You need to enter 'hint' or four numbers between 1 and 6./).to_stdout
      end
    end
  end
end
