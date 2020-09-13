# Controller for sending out automated quotes to customers.
require 'prawn'
class SendQuoteMailer < ApplicationMailer
  # Method which sends out the email.
  def send_quote(to, quote)
    @info = quote
    @price = calculate_quote(quote)
    create_quote_file(quote, @price)
    attachments['quote.pdf'] = File.read("#{Rails.root}/tmp/quote_#{@info.id.to_s}.pdf")
    puts "Done attaching file"
    mail(to: to, subject: 'A Quote From TheCompCodes') 
  end

  private

  # Calculate the quote for the cusomter.
  def calculate_quote(quote)
    #TODO
    100
  end

  def create_quote_file(quote, price)
    "Creating quote file"
    Prawn::Document.generate("#{Rails.root}/tmp/quote_#{@info.id.to_s}.pdf") do
      text "Your price is #{price} dollars"
    end
  end
end
