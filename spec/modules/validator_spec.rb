# frozen_string_literal: true

# RSpec.describe Console do
#   let(:subject) { described_class.new }

#   describe 'valid_check' do
#     context 'validated_name' do
#       it do
#         allow(subject).to receive(:input).and_return('john')
#         expect(subject.validated_name).to eq('John')
#       end
#     end

#     context 'validated_difficult' do
#       it do
#         allow(subject).to receive(:input).and_return('easy')
#         expect(subject.validated_difficult).to eq('easy')
#       end
#     end

#     context 'validated_guess' do
#       it do
#         allow(subject).to receive(:input).and_return('1111')
#         expect(subject.validated_guess).to eq('1111')
#       end
#     end
#   end

#   describe 'invliad_check' do
#     context 'wrong_validated_name' do
#       it do
#         allow(subject).to receive(:input).and_return('', 'Nick')
#         expect(subject).to receive(:input).twice
#         subject.validated_name
#       end
#     end

#     context 'wrong_validated_choice' do
#       it do
#         allow(subject).to receive(:input).and_return('', 'start')
#         expect(subject).to receive(:input).twice
#         subject.validated_choice
#       end
#     end

#     context 'wrong_validated_difficult' do
#       it do
#         allow(subject).to receive(:input).and_return('', 'hell')
#         expect(subject).to receive(:input).twice
#         subject.validated_difficult
#       end
#     end

#     context 'wrong_validated_guess' do
#       it do
#         allow(subject).to receive(:input).and_return('', '1234')
#         expect(subject).to receive(:input).twice
#         subject.validated_guess
#       end
#     end
#   end
# end
