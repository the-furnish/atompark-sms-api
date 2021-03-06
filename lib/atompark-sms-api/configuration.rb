module AtomparkSmsApi
  def self.config
    @configuration ||= AtomparkSmsApi::Configuration.new
  end

  def self.configure
    yield config if block_given?
  end

  class Configuration
    attr_accessor :pubkey, :pvtkey, :base_url, :sender, :test

    def initialize
      @pubkey = ''
      @pvtkey = ''
      @sender = ''
      @test = false
      @base_url = 'http://api.atompark.com/sms/3.0/'
    end
  end
end
