class ReferenceCodeMailer < ApplicationMailer
  def send_ref_code(to, user)
    @info = user
    mail(to: to, from: "christian@thecompcodes.com",
         subject: 'Free TheCompCodes SWAG')
  end
end
