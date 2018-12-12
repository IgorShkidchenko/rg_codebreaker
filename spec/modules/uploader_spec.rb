# frozen_string_literal: true

RSpec.describe Console do
  let(:path) { './spec/fixtures/test_database.yaml' }
  let(:result_double) { double('ResultStatistics') }
  let(:first_name_when_NOT_sort_db) { 'Player5' }

  before { stub_const('Uploader::PATH', path) }

  describe '#load_db' do
    it { expect(subject.load_db.empty?).to eq(false) }
    it { expect(subject.load_db.first.name).to eq(first_name_when_NOT_sort_db) }
  end

  describe '#save_to_db' do
    it do
      db = subject.load_db
      expect { subject.save_to_db(result_double) }.to change { subject.load_db.count }.by(1)
      File.truncate(path, 0)
      db.each { |statistic| subject.save_to_db(statistic) }
    end
  end
end
