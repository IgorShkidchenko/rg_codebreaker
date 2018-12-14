# frozen_string_literal: true

RSpec.describe Uploader do
  subject(:console) { Console.new }

  let(:path) { 'spec/fixtures/test_database.yml' }
  let(:result_double) { double('ResultStatistics') }

  before do
    File.new(path, 'w+')
    stub_const('Uploader::PATH', path)
    console.save_to_db(result_double)
  end

  after { File.delete(path) }

  describe '#save_to_db' do
    it { expect { console.save_to_db(result_double) }.to change { console.load_db.count }.by(1) }
  end

  describe '#load_db' do
    it { expect(console.load_db.empty?).to eq(false) }
  end
end
