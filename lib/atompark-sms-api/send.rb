class AtomparkSmsApi::Send < AtomparkSmsApi::Gateway
  def self.perform(options)
    new(:sendSMS, {sender: AtomparkSmsApi.config.sender, datetime: '', sms_lifetime: 0}.merge(options)).perform
  end
end
