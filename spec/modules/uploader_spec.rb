# frozen_string_literal: true

RSpec.describe Console do
  let(:path) { './spec/fixtures/test_database.yaml' }
  let(:result) { double('ResultStatistics') }
  before { stub_const('Uploader::PATH', path) }

  describe '#load_db' do
    it { expect(subject.load_db.first.name).to eq('Player5') }
  end

  describe '#sort_db' do
    it { expect(subject.sort_db.first.name).to eq('Player1') }
  end

  describe '#save_to_db' do
    it do
      db = subject.load_db
      expect { subject.save_to_db(result) }.to change { subject.load_db.count }.by(1)
      File.truncate(path, 0)
      db.each { |statistic| subject.save_to_db(statistic) }
    end
  end
end
