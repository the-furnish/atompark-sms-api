require 'spec_helper'

describe AtomparkSmsApi::Send do
  subject { described_class.perform(params) }
  let(:faraday) { double }

  before do
    AtomparkSmsApi.configure do |c|
      c.pubkey = 'X'
      c.pvtkey = 'Y'
      c.test = false
      c.sender = 'Pupkin'
    end
  end

  let(:params) { {phone: '000', text: 'xxx'} }

  context 'correct gw call' do
    before do
      expect(described_class).to receive(:new)
        .with(:sendSMS, {sender: 'Pupkin', datetime: '', sms_lifetime: 0, phone: '000', text: 'xxx'})
        .and_return(double(perform: 'performed'))
    end

    it { expect{subject}.to_not raise_error }
    it { expect(subject).to eq("performed") }
  end

  describe '#perform' do
    before do
      expect(Faraday).to receive(:new).with(url: AtomparkSmsApi.config.base_url).and_return(faraday)
      expect(faraday).to receive(:post).and_return(double(body: response))
    end

    context 'success' do
      let(:response) { %Q{{"result" : { "id" : 1 }}} }
      it { expect{subject}.to_not raise_error }
      it { expect(subject.success?).to be_truthy }
      it { expect(subject.id).to eq(1) }
    end

    context 'failed' do
      let(:response) { %Q{{"result" : 1, "code" : 2, "error" : "woops"}} }
      it { expect{subject}.to_not raise_error }
      it { expect(subject.success?).to be_falsey }
      it { expect(subject.error).to eq("<2:1> woops") }
    end
  end
end
