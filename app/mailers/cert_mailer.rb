class CertMailer < ActionMailer::Base
  default from: "records@billericaema.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cert_mailer.cert_expiring.subject
  #
  def cert_expiring(person)
    @person = person  #This instance variable can now be used in the view

    mail to: person.channels.first.content, subject: 'Some of your certifications are expiring.'
  end
end
