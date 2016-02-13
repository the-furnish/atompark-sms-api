require 'spec_helper'

describe AtomparkSmsApi::Gateway do
  it { expect{described_class.perform}.to raise_error(RuntimeError, "Don't call me that way") }

  describe '#perform' do
    let(:faraday) { double }
    let(:method) { :some_call }
    let(:params) { { } }

    before do
      expect(Faraday).to receive(:new).with(url: AtomparkSmsApi.config.base_url).and_return(faraday)
    end

    subject { described_class.new(method, params) }

    describe '#checksum' do
      let(:params) { {foo: 'bar'} }
      before do
        AtomparkSmsApi.configure do |c|
          c.pubkey = 'X'
          c.pvtkey = 'Y'
          c.test = false
        end
      end

      # some_callbarX3.0Y - md5 sum, params in order: action, foo, pubkey, version, pvtkey
      it { expect(subject.send(:checksum)).to eq('72c28714005950deb5ed6ed80d20a9ad') }
    end

    describe '#perform' do
      context 'success' do
        before do
          expect(faraday).to receive(:post).and_return(double(body: %Q{{"result" : {"id" : 10}}}))
        end

        it { expect{subject.perform}.to_not raise_error }
        it { expect(subject.perform).to be_kind_of(AtomparkSmsApi::Response) }
        it { expect(subject.perform.success?).to be_truthy }
        it { expect(subject.perform.id).to eq(10) }
      end

      context 'failed' do
        before do
          expect(faraday).to receive(:post).and_return(double(body: %Q{{"result" : 1, "code" : 2, "error" : "some error"}}))
        end

        it { expect{subject.perform}.to_not raise_error }
        it { expect(subject.perform).to be_kind_of(AtomparkSmsApi::Response) }
        it { expect(subject.perform.success?).to be_falsey }
        it { expect(subject.perform.error).to eq("<2:1> some error") }
      end
    end
  end
end
