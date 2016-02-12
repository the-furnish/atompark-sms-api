class AtomparkSmsApi::Response
  def initialize(data)
    @response = JSON.parse(data)
  end

  def success?
    !error?
  end

  def error?
    response.has_key?('error')
  end

  def message
    "<#{response['code']}> #{response['error']}"
  end

  private

  attr_reader :response
end
