# Controller for sending out automated quotes to customers.
class SendQuoteMailer < ApplicationMailer
  # Method which sends out the email.
  def send_quote(to, quote)
    @info = quote
    @price = calculate_quote(quote)
    mail(to: to, subject: 'A Quote From TheCompCodes') 
  end

  private

  # Calculate the quote for the cusomter.
  def calculate_quote(quote)
    #TODO
    100
  end
end
