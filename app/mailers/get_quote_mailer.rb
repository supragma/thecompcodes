# Controller for sending out when there is a new quote request.
class GetQuoteMailer < ApplicationMailer

  # Method which sends out the email.
  def new_quote(quote)
    @info = quote
    mail(to: 'christian@thecompcodes.com', subject: 'There is a new quote request') 
  end
end
