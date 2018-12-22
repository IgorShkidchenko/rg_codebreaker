# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    subject(:console) { described_class.new }

    let(:path_to_test_db) { './spec/fixtures/test_database.yaml' }
    let(:user_double) { instance_double('User', name: valid_name) }
    let(:game_double_with_zeros) { instance_double('Game', attempts: 0, hints: 0) }
    let(:difficulty_double) { instance_double('Difficulty', level: Difficulty::DIFFICULTIES[:easy]) }
    let(:game_double) do
      instance_double('Game', attempts: Difficulty::DIFFICULTIES[:easy][:attempts],
                              hints: Difficulty::DIFFICULTIES[:easy][:hints])
    end

    let(:valid_numbers) { Game::INCLUDE_IN_GAME_NUMBERS.map(&:to_s) }
    let(:valid_path) { [Console::COMMANDS[:start], user_double.name, Difficulty::DIFFICULTIES[:easy][:level]] }
    let(:valid_guess) { valid_numbers.sample(4).join }
    let(:valid_name) { 'a' * User::VALID_NAME_SIZE.first }

    let(:invalid_guess) { (Game::INCLUDE_IN_GAME_NUMBERS.max + 1).to_s * (Game::CODE_SIZE - 1) }
    let(:invalid_max_length) { 'a' * (User::VALID_NAME_SIZE.max + 1) }
    let(:invalid_min_length) { 'a' * (User::VALID_NAME_SIZE.min - 1) }
    let(:two_invalid_strings) { [invalid_max_length, invalid_min_length] }

    describe '.new' do
      it { expect(console.instance_variable_get(:@errors)).to eq([]) }
    end

    describe '#greating' do
      it do
        expect(Representer).to receive(:greeting_msg)
        console.greeting
      end
    end

    describe 'navigate' do
      after { console.main_menu }

      describe '#main_menu' do
        before { allow(console).to receive(:registration) }

        context 'when registration_redirect' do
          it do
            allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start])
            expect(console).to receive(:registration)
          end
        end

        context 'when #show_rules_redirect_and_show' do
          it do
            allow(console).to receive(:user_input).and_return(Console::COMMANDS[:rules], Console::COMMANDS[:start])
            expect(Representer).to receive(:show_rules)
          end
        end

        context 'when statistics_redirect' do
          it do
            allow(console).to receive(:user_input).and_return(Console::COMMANDS[:stats], Console::COMMANDS[:start])
            expect(console).to receive(:statistics)
          end
        end

        context 'when invalid' do
          it do
            allow(console).to receive(:user_input).and_return(*two_invalid_strings, Console::COMMANDS[:start])
            expect(Representer).to receive(:error_msg).twice
          end
        end
      end

      context 'when redirect_to_make_guess' do
        it do
          allow(console).to receive(:user_input).and_return(*valid_path)
          expect(console).to receive(:make_guess)
        end
      end
    end

    describe 'check_loops' do
      before { expect(console).to receive(:user_input).exactly(3).times }

      context 'when #make_valid_input_for_class(Guess)' do
        it do
          allow(console).to receive(:user_input).and_return(invalid_min_length, invalid_guess, valid_guess)
          console.send(:make_valid_input_for_class, Guess)
        end
      end

      context 'when #make_valid_input_for_class(User)' do
        it do
          allow(console).to receive(:user_input).and_return(*two_invalid_strings, user_double.name)
          console.send(:make_valid_input_for_class, User)
        end
      end

      context 'when #choose_difficulty' do
        it do
          allow(console).to receive(:user_input).and_return(*two_invalid_strings, Difficulty::DIFFICULTIES[:easy][:level])
          console.send(:choose_difficulty)
        end
      end
    end

    describe '#show_hint' do
      after do
        allow(console.instance_variable_get(:@game)).to receive(:hint)
        console.send(:show_hint)
      end

      context 'with_some_hints' do
        it do
          console.instance_variable_set(:@game, game_double)
          expect(Representer).to receive(:showed_hint_msg)
        end
      end

      context 'with_zero_hints' do
        it do
          console.instance_variable_set(:@game, game_double_with_zeros)
          expect(Representer).to receive(:zero_hints_msg)
        end
      end
    end

    describe '#check_round_result' do
      before do
        console.instance_variable_set(:@game, game_double_with_zeros)
        allow(console.instance_variable_get(:@game)).to receive(:win?)
      end

      after do
        allow(console.instance_variable_get(:@game)).to receive(:start_round)
        console.send(:check_round_result, nil)
      end

      before { allow(console.instance_variable_get(:@game)).to receive(:lose?).and_return(false) }

      context 'when redirect_to_lose_if_zero_attempts_left' do
        it do
          allow(console.instance_variable_get(:@game)).to receive(:lose?).and_return(true)
          expect(console).to receive(:lose)
        end
      end

      context 'when show_round_info_text_if_pass_win_and_lose_checks' do
        it { expect(Representer).to receive(:round_info_text) }
      end

      context 'when redirect_to_win_if_guess_eq_code' do
        it do
          allow(console.instance_variable_get(:@game)).to receive(:win?).and_return(true)
          expect(console).to receive(:win)
        end
      end
    end

    describe 'save_result' do
      it do
        console.instance_variable_set(:@game, game_double)
        expect(console.instance_variable_get(:@game)).to receive(:to_h)
        expect(console).to receive(:save_to_db)
        console.send(:save_result)
      end
    end

    describe '#lose' do
      it do
        expect(console).to receive(:start_new_game)
        console.send(:lose)
      end
    end

    describe '#win' do
      it 'with_yes' do
        allow(console).to receive(:user_input).and_return(Console::ACCEPT_SAVING_RESULT)
        allow(console).to receive(:start_new_game)
        expect(console).to receive(:save_result)
        console.send(:win)
      end

      it 'with_no' do
        allow(console).to receive(:user_input) { invalid_min_length }
        allow(described_class).to receive_message_chain(:new, :main_menu)
        expect(console).not_to receive(:save_result)
        console.send(:win)
      end
    end

    describe '#statistics' do
      before { allow(console).to receive(:main_menu) }

      context 'when with_empty_db' do
        it do
          allow(console).to receive(:load_db).and_return([])
          expect(Representer).to receive(:empty_db_msg)
          console.send(:statistics)
        end
      end

      context 'when with_not_empty_db' do
        it do
          allow(console).to receive(:load_db).and_return([nil])
          expect(Representer).to receive(:show_db)
          console.send(:statistics)
        end
      end
    end

    describe '#user_input' do
      it do
        expect(console).to receive_message_chain(:gets, :chomp, :downcase)
        console.send(:user_input)
      end
    end

    describe '#exit_console' do
      it { expect { console.send(:exit_console) }.to raise_error(SystemExit) }
    end
  end
end
