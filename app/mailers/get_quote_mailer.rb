# Controller for sending out when there is a new quote request.
class GetQuoteMailer < ApplicationMailer

  # Method which sends out the email.
  def new_quote(to, quote)
    @info = quote
    mail(to: to, subject: 'There is a new quote request') 
  end
end
