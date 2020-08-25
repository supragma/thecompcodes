# Controller for Contact Us Mailer.
class ContactusMailer < ApplicationMailer

  # Method for notifying us about a new contact message.
  def new_contact_us(message)
    @email = message.email
    @name = message.name
    @msg = message.message
    mail(to: 'christian@thecompcodes.com', subject: "There is a new contact message")
  end
end
