class SmsController < ApplicationController

  def send_message
    @message = @client.messages.create(
      from:  '+12015784557',     
	    to: '+13082934761',
      body: 'Rails TEST'
    )
  end
  
  def reply
    # boot_twilio

    @account = @client.account


    

    byebug

    response = Twilio::TwiML::Response.new do |r|
      r.Message 'Hey guys'
    end

    response.to_xml

    render 'process_sms.xml.erb', :content_type => 'text/xml'
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
