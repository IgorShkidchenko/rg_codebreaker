# frozen_string_literal: true

# RSpec.describe Console do
#   let(:subject) { described_class.new }

#   it 'check_lose' do
#     allow(subject).to receive(:what_next)
#     expect { subject.lose }.to output(/Game over, you lose if you want you can start a new game/).to_stdout
#   end

#   it 'check_win' do
#     allow(subject).to receive(:what_next)
#     allow(subject).to receive(:gets).and_return('')
#     expect { subject.win }.to output(/You win/).to_stdout
#   end

#   context 'check_registration' do
#     it do
#       allow(subject).to receive(:go_game)
#       allow(subject).to receive(:validated_name).and_return('Nick')
#       allow(subject).to receive(:select_difficult).and_return(hints: 2, attempts: 15, level: 'easy')
#       expect { subject.registration }.to output(/You log in as Nick/).to_stdout
#     end
#   end

#   context 'check_show_hint' do
#     let(:game) { Game.new('John', hints: 2, attempts: 15, level: 'easy') }

#     before do
#       allow(subject).to receive(:go_game)
#     end

#     it 'check_with_some_hints' do
#       subject.instance_variable_set(:@game, game)
#       expect { subject.show_hint }.to output(/Code contains this number: /).to_stdout
#     end

#     it 'check_with_zero_hints' do
#       game.instance_variable_set(:@hints, 0)
#       subject.instance_variable_set(:@game, game)
#       expect { subject.show_hint }.to output(/You don't have any hints/).to_stdout
#     end
#   end

#   # expect { subject.save_to_db }.to change { subject.load_db.count }.by(1)
#   # context 'check_go_game' do
#   #   before do
#   #     allow(subject).to receive(:select_difficult).and_return(hints: 2, attempts: 1, level: 'easy')
#   #     allow(subject).to receive(:validated_guess)
#   #   end

#   #   it 'check_attempts_decrease' do
#   #     allow(subject).to receive(:start)
#   #     allow(subject).to receive(:lose)
#   #     subject.registration
#   #     expect(subject.attempts).to eq 1
#   #     expect { subject.go_game }.to output(/Your result is /).to_stdout
#   #     expect(subject.attempts).to eq 0
#   #   end
#   # end

#   context '#check_difficult_module' do
#     it 'check_easy' do
#       allow(subject).to receive(:validated_difficult).and_return('easy')
#       expect(subject.select_difficult).to eq(hints: 2, attempts: 15, level: 'easy')
#     end

#     it 'check_medium' do
#       allow(subject).to receive(:validated_difficult).and_return('medium')
#       expect(subject.select_difficult).to eq(hints: 1, attempts: 10, level: 'medium')
#     end

#     it 'check_hell' do
#       allow(subject).to receive(:validated_difficult).and_return('hell')
#       expect(subject.select_difficult).to eq(hints: 1, attempts: 5, level: 'hell')
#     end
#   end
# end
