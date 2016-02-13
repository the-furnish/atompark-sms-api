require 'spec_helper'

describe AtomparkSmsApi::Response do
  subject { described_class.new(response) }

  describe 'invalid' do
    let(:response) { 'foo' }

    it { expect{subject}.to raise_error(JSON::ParserError, "776: unexpected token at 'foo'") }
  end

  describe '#error' do
    let(:response) { %Q{{"error" : "some error", "code" : "-1", "result" : 2}} }

    it { expect{subject}.to_not raise_error }
    it { expect(subject.error?).to be_truthy }
    it { expect(subject.success?).to be_falsey }
    it { expect(subject.error).to eq('<-1:2> some error') }

    it { expect{subject.id}.to raise_error(RuntimeError, '<-1:2> some error') }
    it { expect{subject.price}.to raise_error(RuntimeError, '<-1:2> some error') }
    it { expect{subject.currency}.to raise_error(RuntimeError, '<-1:2> some error') }
  end

  describe '#success' do
    let(:response) { %Q{{"result" : {"id" : 1, "price" : 2.5, "currency" : "USD"}}} }

    it { expect{subject}.to_not raise_error }
    it { expect(subject.error?).to be_falsey }
    it { expect(subject.success?).to be_truthy }
    it { expect(subject.id).to eq(1) }
    it { expect(subject.price).to eq(2.5) }
    it { expect(subject.currency).to eq("USD") }
  end
end
