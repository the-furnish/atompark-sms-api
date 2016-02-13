require 'spec_helper'

describe AtomparkSmsApi::Configuration do
  subject { AtomparkSmsApi.config }

  it { expect(subject.pubkey).to eq('') }
  it { expect(subject.pvtkey).to eq('') }
  it { expect(subject.sender).to eq('') }
  it { expect(subject.base_url).to eq('http://api.atompark.com/sms/3.0/') }
  it { expect(subject.test).to be_falsey }

  shared_examples_for 'set variable' do |var, val|
    before { AtomparkSmsApi.configure { |c| c.send(:"#{var}=", val) } }
    it { expect(subject.send(var)).to eq(val) }
  end

  it_behaves_like 'set variable', :pubkey, 'public key'
  it_behaves_like 'set variable', :pvtkey, 'private key'
  it_behaves_like 'set variable', :sender, 'IvanPteroff'
  it_behaves_like 'set variable', :test, true
  it_behaves_like 'set variable', :base_url, '/dev/null'
end
