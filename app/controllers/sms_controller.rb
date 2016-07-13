class SmsController < ApplicationController

  def send_message
    @message = @client.messages.create(
      from:  '+12015784557',     
	    to: '+13082934761',
      body: 'Rails TEST'
    )
  end

     #Params: {"ToCountry"=>"US", "ToState"=>"NJ", "SmsMessageSid"=>"SMca238e8b0ad0f9e0fe1399af8160497e", "NumMedia"=>"0", "ToCity"=>"TEANECK", "FromZip"=>"68845", "SmsSid"=>"SMca238e8b0ad0f9e0fe1399af8160497e", "FromState"=>"NE", "SmsStatus"=>"received", "FromCity"=>"KEARNEY", "Body"=>"Hi", "FromCountry"=>"US", "To"=>"+12015784557", "ToZip"=>"07666", "NumSegments"=>"1", "MessageSid"=>"SMca238e8b0ad0f9e0fe1399af8160497e", "AccountSid"=>"ACfb7fc67e55e599355eaa728c323068fc", "From"=>"+13082934761", "ApiVersion"=>"2010-04-01", "controller"=>"sms", "action"=>"reply"} 

  def reply
    @params = params

    if params['Body'] == "Start" 
      render 'reply.xml.erb', :content_type => 'text/xml'
      start_transaction_logging
    end
  end

  def start_transaction_logging
    @params = params
    @location = @params['Body']
    render 'start.xml.erb', :content_type => 'text/xml'
  end

  def send_message_via_sms(message)
    boot_twilio

    @app_number = ENV['twilio_number']
    @client.account.messages.create(
      from: @app_number,
      to: self.phone_number,
      body: message,
    )
  end

  private

  def boot_twilio
    # account_sid = ENV['test_account_sid'] 
    # auth_token = ENV['test_auth_token']
    account_sid = ENV['account_sid'] 
    auth_token = ENV['auth_token']

    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

end
