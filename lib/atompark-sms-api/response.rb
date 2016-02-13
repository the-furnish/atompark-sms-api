require 'json'

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

  def error
    "<#{response['code']}:#{response['result']}> #{response['error']}"
  end

  %w(id price currency).each do |key|
    define_method(key) do
      result[key]
    end
  end

  private

  attr_reader :response

  def result
    fail error if error?
    response['result']
  end
end
