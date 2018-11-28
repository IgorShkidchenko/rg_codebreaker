# frozen_string_literal: true

RSpec.describe Console do
  let(:subject) { described_class.new }

  it 'check_greeting_msg' do
    expect { subject }.to output(/Hello, lets play the 'Codebreaker' game/).to_stdout
  end

  it 'check_what_next_method' do
    expect(subject).to receive(:what_next).and_return(:what_next_text)
    subject.what_next
  end

  it 'check_validated_choice_method' do
    expect(subject).to receive(:what_next).and_return(:validated_choice)
    subject.what_next
  end
end
