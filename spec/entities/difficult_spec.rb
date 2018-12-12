# frozen_string_literal: true

# RSpec.describe Difficult do
#   let(:subject) { described_class.new('easy') }

#   describe '#validate_and_valid?' do
#     context 'valid' do
#       it do
#         expect do
#           subject.validate
#           expect(subject.errors).to eq([])
#         end.to change { subject.errors.size }.by(0)
#       end

#       it { expect(subject.valid?).to eq(true) }
#     end

#     context 'invalid' do
#       it do
#         subject.instance_variable_set(:@input, '')
#         expect do
#           subject.validate
#           expect(subject.errors).to eq(['Not include in propose inputs'])
#         end.to change { subject.errors.size }.by(1)
#       end

#       it do
#         subject.instance_variable_set(:@errors, [''])
#         expect(subject.valid?).to eq(false)
#       end
#     end
#   end

#   describe '#select_difficult' do
#     context 'level_easy' do
#       it do
#         subject.select_difficult
#         expect(subject.level).to eq(Difficult::DIFFICULTIES[:easy])
#       end
#     end

#     context 'level_medium' do
#       it do
#         subject.instance_variable_set(:@input, 'medium')
#         subject.select_difficult
#         expect(subject.level).to eq(Difficult::DIFFICULTIES[:medium])
#       end
#     end

#     context 'level_hell' do
#       it do
#         subject.instance_variable_set(:@input, 'hell')
#         subject.select_difficult
#         expect(subject.level).to eq(Difficult::DIFFICULTIES[:hell])
#       end
#     end
#   end
# end
