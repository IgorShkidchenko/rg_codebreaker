# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:path) { './spec/fixtures/test_database.yaml' }
  let(:result_double) { double('ResultStatistics') }
  let(:first_name_when_NOT_sort_db) { 'Player5' }

  before { stub_const('Uploader::PATH', path) }

  describe '#load_db' do
    it { expect(console.load_db.empty?).to eq(false) }
    it { expect(console.load_db.first.name).to eq(first_name_when_NOT_sort_db) }
  end

  describe '#save_to_db' do
    it do
      db = console.load_db
      expect { console.save_to_db(result_double) }.to change { console.load_db.count }.by(1)
      File.truncate(path, 0)
      db.each { |statistic| console.save_to_db(statistic) }
    end
  end
end
