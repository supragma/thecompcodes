# Controller for sending out automated hellos to customers.
class SendHelloMailer < ApplicationMailer
  # Method which sends out the email.
  def send_hello(to, quote)
    @info = quote
    mail(to: to, from: "christian@thecompcodes.com", 
         subject: 'A Quote From TheCompCodes') 
  end
end
