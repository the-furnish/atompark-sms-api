class AtomparkSmsApi::Gateway
  def self.perform(*args)
    fail "Don't call me that way"
  end

  def initialize(method, params)
    @method = method
    @params = params.merge(action: method, key: AtomparkSmsApi.config.pubkey, version: '3.0')
    @conn = Faraday.new(url: AtomparkSmsApi.config.base_url)
#    do |faraday|
#      faraday.response(:logger)
 #   end
  end

  def perform
    AtomparkSmsApi::Response.new(perform!)
  end

  private

  attr_reader :method, :conn, :params

  def perform!
    conn.post do |req|
      req.url(method.to_s)
      req.params = params.merge(sum: checksum)
    end.body
  end

  def checksum
    @_checksum ||= Digest::MD5.hexdigest(params.sort.map{ |v| v[1] }.join('') + AtomparkSmsApi.config.pvtkey)
  end
end
